function M = Norm(A)
    M = (A - min(A(:))) / (max(A(:)) - min(A(:)));
end