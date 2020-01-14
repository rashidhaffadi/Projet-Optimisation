function S = Adamax(sg, s0, N, idxs, alpha, beta1, beta2)

% References:
%    Kingma, Diederik and Ba, Jimmy. Adam: A Method for Stochastic
%       Optimization.
%
% Entrées:
%   sg       : fonction qui calcule le gradient stochastic pour un indice donnée 
%   s0       : solution initiale
%   N    : nombre d'itérations
%   idxs    : indices pour la fonction choisie (fonction objective sous
%   forme d'une somme de fonctions)
%   alpha    : pas fixe
%   beta1    : exp. decay rate for the 1st moment estimate 
%   beta2    : exp. decay rate for the exp. weighted infinity norm
%
% Output:
%   S     : solution pour chaque itération
%

% la dimension du probléme : le nombre de paramétres
d = length(s0);

% initialisation
S = zeros(d, N + 1);

% Set the initial guess
S(:, 1) = s0;

% Initialise moment estimate and the exponentially weighted infinity norm
m = zeros(d, 1);
u = zeros(d, 1);
betaT = 1;
epsilon = 1e-5;
% Run optimisation
for t = 1 : 1 : N
    % Get gradients w.r.t. stochastic objective at the current iteration
    gt = sg(idxs(:, t), S(:, t));
    
    % Update biased 1st moment estimate
    
    m = beta1.*m + (1 - beta1).*gt;
    % Update the exponentially weighted infinity norm
    u = max(beta2.*u, abs(gt));
    
    % Compute the bias-corrected 1st moment estimate
    betaT = betaT*beta1;
    mHat = m./(1 - betaT);
    
    % Update decision variables
    S(:, t + 1) = S(:, t) - alpha.*mHat./(u+epsilon);
end

end
