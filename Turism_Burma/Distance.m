function y = Distance(x)
    load('distance_matrix.mat');
    d = 0;
    for i = 1:numel(x)-1
        d = d + distance_matrix(x(i),x(i+1));
        y = d;
    end
end