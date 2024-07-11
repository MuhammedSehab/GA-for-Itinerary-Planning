function [y1, y2] = COX(p1, p2)
    x1 = p1;
    x2 = p2;
    n = length(x1);
    
    % Generate two random crossover points
    cp1 = randi([2,n-2]);
    cp2 = randi([cp1+1, n-1]);
    
    % Subsets
    subset11 = x1(1:cp1);
    subset12 = x1(cp2+1:end);
    subset21 = x2(1:cp1);
    subset22 = x2(cp2+1:end);

    % find indices of subset in both rows
    [~, idx11_1] = ismember(subset11, p1);
    [~, idx11_2] = ismember(subset11, p2);

    [~, idx12_1] = ismember(subset12, p1);
    [~, idx12_2] = ismember(subset12, p2);

    [~, idx21_1] = ismember(subset21, p1);
    [~, idx21_2] = ismember(subset21, p2);

    [~, idx22_1] = ismember(subset22, p1);
    [~, idx22_2] = ismember(subset22, p2);

    % reordering 
    x1(idx11_1)=p2(sort(idx11_2));
    x1(idx12_1)=p2(sort(idx12_2));
    x2(idx21_2)=p1(sort(idx21_1));
    x2(idx22_2)=p1(sort(idx22_1));


    % Put the reordered segments together
    y1 = [x1(1:cp1), p1(cp1+1:cp2), x1(cp2+1:end)];
    y2 = [x2(1:cp1), p2(cp1+1:cp2), x2(cp2+1:end)];
    
end