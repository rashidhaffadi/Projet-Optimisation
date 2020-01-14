function alpha = f_rule(iter, idx, dt, gt, m, S, gamma)

%%%%%% Tests sur les arguments %%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%% les fonction ft %%%%%%%%%%%%%%%%%%%
f_a = @Tests.function1.f_a;
f = @Tests.function1.f;
%%%%%%%%%%% Initialiser alpha par 1 %%%%%%%%%%%%%
alpha = 1/2;

%%%%%%%%%%%%%%%% Initialiser lambda %%%%%%%%%%%%%
%Soit lambda = 2/(m*(m+1)) ou bien lambda = 1/m
%et choisire lambdai = 2i/(m*(m+1)) ou bien lambdai = 1/m
lambda = zeros(1,m);
for i = 1:1:m
    %lambda(i) = 2*i/(m*(m+1));
    lambda(i) = 1/m;
end

somme=0;
for i=1:1:m
    somme = somme + lambda(i)*f(idx, S(:,iter-i+2));
end

while (f_a(idx, S(:, iter), alpha, dt) > (max(f(idx, S(:, iter)), somme) + gamma*alpha*(gt*dt')))
    if alpha < 1e-4
        break;
    end
    alpha = 4*alpha/5;
end

end

