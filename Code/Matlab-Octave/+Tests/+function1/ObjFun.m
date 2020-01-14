function J = ObjFun(x)
Q = [1 2; 2 1; 0.5 0.5; 1 3; 2 2; 3 1; 1 1; 4 1; 1 4; 3 3; 4 4];

n = length(Q);
f = @Tests.function1.f;
J = 0;
for i=1:1:n
    J = J + f(i,x);
end
J = J/n;

end
