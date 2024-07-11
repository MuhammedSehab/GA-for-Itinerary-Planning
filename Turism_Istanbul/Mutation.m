function y = Mutation(x, mu)
    n = numel(x);
    flag = (rand(n) < mu);
    for i = 2:n-1
        if flag(i,:) == 1
            temp = x(i);
            x(i)=x(i+1);
            x(i+1)=temp;
        end
    end
    y = x;
        
end