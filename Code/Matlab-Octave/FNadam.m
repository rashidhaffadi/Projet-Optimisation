function S = FNadam(sg, x0, N, idxs, mu, nu, epsilon, gamma, M)

% Store the number of decision variables
d = length(x0);

% Allocate output
S = zeros(d, N + 1);

% Set the initial guess
S(:, 1) = x0;

% Initialise moment estimate and the exponentially weighted infinity norm
m = zeros(d, 1);
n = zeros(d, 1);
muT = mu;
nuT = 1;
for t = 1 : 1 : N
    % Get gradients w.r.t. stochastic objective at the current iteration
    gt = sg(idxs(:, t), S(:, t));
    
    % Update biased 1st moment estimate
    m = mu.*m + (1 - mu).*gt;
    
    %Update the moment n
    n = nu.*n + (1 - nu).*(gt.^2);
    
    %Calculate mHat
    muT = muT * mu;
    mHat = (mu.*m./(1-muT)) + ((1-mu).*gt./(1-muT));
    
    %Calculate nHat
    nuT = nuT * nu;
    nHat = nu.*n./(1-nuT);
    
    %Calcule du pas
    dt = -mHat./(sqrt(nHat + epsilon));
    mt = min(t+1,M);
    alpha = f_rule(t, idxs(t), dt, gt, mt, S, gamma);
    S(:, t + 1) = S(:, t) + alpha.*dt;
    
end
end

