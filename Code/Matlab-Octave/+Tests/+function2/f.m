function scores = f(i,x)
    n = size(x, 2);
    assert(n == 2, 'Beale''s function is only defined on a 2D space.')
    X = x(:, 1);
    Y = x(:, 2);
    switch i
        case 1
            scores = ((1.5 - X + (X .* Y)).^2)/3000;
        case 2
            scores = ((2.25 - X + (X .* (Y.^2))).^2)/3000;
        case 3
            scores = ((2.625 - X + (X .* (Y.^3))).^2)/3000;
        otherwise
            error('Index of function out of bound');
            
    end
end
