function S = Adam(sg, x0, nIter, index, stepSize, beta1, beta2, epsilon)


if nargin == 7
    epsilon = sqrt(eps);
end

% Store the number of decision variables
nDecVar = length(x0);

% Allocate output
S = zeros(nDecVar, nIter + 1);

% Set the initial guess
S(:, 1) = x0;

% Repeat `index` if it has fewer columns than `nIter`
if size(index, 2) < nIter
    index = repmat(index, 1, ceil(nIter/size(index, 2)));
    index(:, nIter + 1 : 1 : end) = [];
end

% Initialise moment estimates
m = zeros(nDecVar, 1);
v = zeros(nDecVar, 1);

% Run optimisation
for i = 1 : 1 : nIter
    % Get gradients w.r.t. stochastic objective at the current iteration
    sgCurr = sg(index(:, i), S(:, i));
    
    % Update biased 1st moment estimate
    m = beta1.*m + (1 - beta1).*sgCurr;
    % Update biased 2nd raw moment estimate
    v = beta2.*v + (1 - beta2).*(sgCurr.^2);
    
    % Compute bias-corrected 1st moment estimate
    mHat = m./(1 - beta1^i);
    % Compute bias-corrected 2nd raw moment estimate
    vHat = v./(1 - beta2^i);
    
    % Update decision variables
    S(:, i + 1) = S(:, i) - stepSize.*mHat./(sqrt(vHat) + epsilon);
end

end
