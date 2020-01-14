function sg = StochGrad(idx, x)

switch idx
    case 1
        sg = [(3+2*x(1)*(x(2)-1))*(x(2)-1) (3+2*x(1)*(x(2)-1))*x(1)]';
    case 2
        sg = [(9/2-2*x(1)+2*x(1)*x(2)^2)*(x(2)^2-1) (9-4*x(1)+4*x(1)*x(2)^2)*(x(1)*x(2))]';
    case 3
        sg = 2*[(21/8 + x(1)*(x(2)^3-1))*(x(2)^3-1) 3*(21/8 + x(1)*(x(2)^3-1))*x(1)*x(2)^2]';
    otherwise
        error('Index of sg out of bound');
end
end
