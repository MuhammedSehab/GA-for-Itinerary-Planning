function output = GA(inputs, parameters)
    % User inputs
    budget = inputs.budget;
    data = inputs.data;
    ObjectFunction = inputs.ObjectFunction;
    nPlaces = inputs.nPlaces;
    
    % GA parameters
    nGen = parameters.nGen;
    nRoute = parameters.nRoute;
    pOff = parameters.pOff;
    nOff = round(pOff*nRoute/2)*2;
    pMut = parameters.pMut;
   
    % Routes initializations
    empty_route.Plan = [];
    empty_route.Fit = [];

    % The best solution initial value
    bestsol.Fit = 0;

    % The initial population
    % All scenarios utilized the same initial population
    load('ind.mat','ind');
    for i = 1:nRoute
        % Finding the Fitness of each Solution
        ind(i).Fit = ObjectFunction(ind(i).Plan,budget);
        % Finding the Best Solution in each generation
        if ind(i).Fit > bestsol.Fit
            bestsol = ind(i);
        end    
    end

    % Best Fitness of each generation
    bestfit = nan(nGen, 1);
    bestcost = nan(nGen, 1);
    bestdistance = nan(nGen, 1);
    besttime = nan(nGen, 1);

    ind = SortPop(ind);
   
    % The Evolution Loop
    for g = 1:nGen
        % Initialize of Offspring Population
        indoff = repmat(empty_route, nOff/2, 2);

        % Crossover
        for k = 1:nOff/2

            % Select Parents
%             % Random Selection Method
%             q = randperm(nRoute);
%             p1 = ind(q(1));
%             p2 = ind(q(2));

            % Tournament Selection Method
            tournamentSize = floor(nRoute *0.2);
            tournament = randperm(nRoute, tournamentSize);
            c = repmat(empty_route, tournamentSize, 1);
            for i = 1:tournamentSize
                c(i) = ind(tournament(i));
            end
            cand = SortPop(c);
            p1 = cand(1);
            p2 = cand(2);

            % Modifiying Tournament Selection by adding this (16 lines) code to the last tournament selection code
            t = 2;
            j = 1 ;
            while p1.Plan==p2.Plan
                t = t + 1;
                if t <= tournamentSize
                    p2 = cand(t);
                else
                    p2 = ind(j);
                    j = j + 1;
                    if j > nOff
                        p2.Plan = Mutation(p1.Plan,0.9);
                        pMut = 0.9;
                        break;
                    end
                end
            end

            % Perform Crossover (CX or COX method)
            [indoff(k, 1).Plan, indoff(k, 2).Plan] = COX(p1.Plan, p2.Plan);
        end

        % Convert the offsprings to Single-Column Matrix
        indoff = indoff(:);
        
        % Mutation
        for M = 1:nOff
            % Perform Mutation
            indoff(M).Plan = Mutation(indoff(M).Plan, pMut);
            % Evaluation
            indoff(M).Fit = ObjectFunction(indoff(M).Plan,budget);
            % Compare Solution to Best Solution ever Found
            if indoff(M).Fit > bestsol.Fit
                bestsol = indoff(M); 
            end    
        end

        % Update Best Fitness of each generation
        bestfit(g) = bestsol.Fit;
        bestcost(g) = TravelCost(bestsol.Plan);
        bestdistance(g) = Distance(bestsol.Plan);
        besttime(g) = Travel_Time(bestsol.Plan);

        % Merge and Sort Population
        ind = SortPop([ind; indoff]);

        % Remove Extra routes
        ind = ind(1:nRoute);

        % Display Iteration Information
        disp(['Generation ' num2str(g) ': Best Fitness = ' num2str(bestfit(g)) ...
            '  with Travel Cost = ' num2str(bestcost(g)) ...
            '  & Total Distance = ' num2str(bestdistance(g)) ...
            '  & Travel Time = ' num2str(besttime(g))]);
    end
    
    % Plotting Data
    figure;
    plot (data(:,2),data(:,3),'ro', 'MarkerFaceColor', 'r');
    text(data(:,2), data(:,3), num2str(data(:,1)));
    grid on;

    % The Best Route Figure
    for i = 1:nPlaces-1
        x1 = data(bestsol.Plan(i),2);
        y1 = data(bestsol.Plan(i),3);
        x2 = data(bestsol.Plan(i+1),2);
        y2 = data(bestsol.Plan(i+1),3);
        hold on;
        plot([x1, x2], [y1, y2], 'k-');
        hold off;
        drawnow;
     end

    % Results
    output.ind = ind;
    output.bestsol = bestsol;
    output.bestfit = bestfit;
    output.bestcost = bestcost;
    output.bestdistance = bestdistance;
    output.besttime = besttime;
    disp(['The Optimal Route: ' num2str(output.bestsol.Plan)]);
   
end