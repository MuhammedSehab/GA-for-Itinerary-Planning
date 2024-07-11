function f = Fitness(x,budget)
    
    % Reading Distance Matrix
    load('Travel_Dis.mat');
    Ndmat = Norm(Travel_Dis);
    
    load('Travel_Times.mat');
    Ntmat = Norm(Travel_Times);

    % Reading Travel Costs Matrix
    n = TravelCost(x);
        
    d = 0;
    for i = 1:numel(x)-1
          d = d + Ndmat(x(i),x(i+1)) + Ntmat(x(i),x(i+1));  
    end
    Npayment = (budget-n)/budget;
    f = Npayment / d;

end