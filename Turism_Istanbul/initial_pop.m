function y = initial_pop(nRoute,nPlaces)
    % Routes initializations
    empty_route.Plan = [];
    empty_route.Fit = [];

    % The Initialization Step defines initial individuals
    individual = repmat(empty_route, nRoute, 1);
    for i = 1:nRoute

        % Producing Randoim Solutions
        range_of_numbers = 1:nPlaces;
        random_indices = randperm(length(range_of_numbers), nPlaces-1);
        A = range_of_numbers(random_indices);
        individual(i).Plan = [6,A];        
    end
    y = individual;
    ind = y;
    save('ind.mat', 'ind');  % save the initial population matrix to a file called initial.mat

end