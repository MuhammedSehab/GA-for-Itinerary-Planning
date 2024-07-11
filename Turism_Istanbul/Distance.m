function y = Distance(x)
    load('Travel_Dis.mat');
    d = 0;
    for i = 1:numel(x)-1
        d = d + Travel_Dis(x(i),x(i+1));
        y = d;
    end
end