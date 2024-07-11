function y = Travel_Time(x)
    load('Travel_Times.mat');
    t = 0;
    for i = 1:numel(x)-1
        t = t + Travel_Times(x(i),x(i+1));
        y = t;
    end
end