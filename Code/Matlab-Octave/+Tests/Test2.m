%% Initialise

clear
close all
clc

%% Objective function and its gradients

% Define the objective function
objFun = @Tests.function1.ObjFun;

% Define the full gradient and the stochastic gradient functions
gs = @Tests.function1.StochGrad;

% Store the number of addends in the stochastic objective
nQa = 11;

% Store the global minimum
objFunGlobMin = 0;

%% Compute the objective function values (for plotting)

rangeX = linspace(-4.5, +4.5, 100);
rangeY = linspace(-4.5, +4.5, 100);

[X, Y] = meshgrid(rangeX, rangeY);

Z = zeros(size(X));

for i = 1 : 1 : length(rangeX)
    for j = 1 : 1 : length(rangeY)
        Z(j, i) = objFun([rangeX(i); rangeY(j)]);
    end
end

%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%
s0 = [1; 1];
N = 150;
idxs = randi(nQa, 1, N);

algos = { ...
    'Adam', ...
    'Adamax', ...
    'Nadam' ... 
    'Fadamax', ...
    'FNadam', ...
    };

S.Adam = Adam(gs, s0, N, idxs, 0.01, 0.9, 0.999);
S.Adamax = Adamax(gs, s0, N, idxs, 0.01, 0.9, 0.999);
S.Nadam = Nadam(gs, s0, N, idxs, 0.01, 0.5, 0.999, 1);
S.Fadamax = Fadamax(gs, s0, N, idxs, 0.9, 0.999, 0.1, 16);
S.FNadam = FNadam(gs, s0, N, idxs, 0.9, 0.999, 1e-2, 0.5, 16);

for i = 1 : 1 : length(algos)
    objFunMat.(algos{i}) = ...
        cellfun(objFun, num2cell(S.(algos{i}), 1));
end

%% Plot results -- Convergence plot

figConvergence = figure( 'Name', 'Convergence behaviour of different algos');
for i = 1 : 1 : length(algos)
    plot(objFunMat.(algos{i}));
    hold on
end
plot([1, N + 1], [1, 1].*objFunGlobMin, 'Color', 'r', 'LineStyle', '--');
hold off
legend([algos, {'Global minimum'}]);
xlim([1, N + 1]);

%% Plot results -- Contour plot of the objective function

figContour = figure('Name', 'Contour plot of the objective function');

surf(X, Y, Z, 'EdgeAlpha', 0.1);
colormap bone
xlabel('x');
ylabel('y');
xlim(rangeX([1, end]));
ylim(rangeY([1, end]));

hold on
for i = 1 : 1 : length(algos)
    plot3(S.(algos{i})(1, :), S.(algos{i})(2, :), ...
        objFunMat.(algos{i}), ...
        'LineWidth', 1.4);
end
plot3(3.0, 0.5, objFunGlobMin, 'o', 'Color', 'g');
hold off
legend([{'Obj fun'}, algos, {'Minimum Globale'}]);
