function ind = SortPop(ind)

    [~, so] = sort([ind.Fit],'descend');
    ind = ind(so);
    
end