function y = TravelCost(x)
    
    load('Travel_Costs.mat');
    d = 0;
    for i = 1:numel(x)-1
        d = d + Travel_Costs(x(i),x(i+1));
    end
    y = d;
end