function sg = StochGrad(idx, x)

Q = [1 2; 2 1; 0.5 0.5; 1 3; 2 2; 3 1; 1 1; 4 1; 1 4; 3 3; 4 4];

p = Q(idx,:);

sg = 2*[p(1)*x(1) p(2)*x(2)]';

end
