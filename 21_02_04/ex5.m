clear all
clc 

% Dati del problema
q0 = [pi/4; 1e-6]; % Configurazione iniziale, con ε molto piccolo
pd1 = [-1; 1];    % Posizione desiderata I
pd2 = [1; 1];     % Posizione desiderata II

% Funzione di kinematica diretta
f = @(q) [q(2) * cos(q(1)); q(2) * sin(q(1))];

% Jacobiano
J = @(q) [-q(2) * sin(q(1)), cos(q(1)); q(2) * cos(q(1)), sin(q(1))];

% Metodo di Newton
newtonIteration = @(q, pd) q + J(q) \ (pd - f(q));

% Metodo del Gradiente
alpha = 0.1; % Passo del gradiente
gradientIteration = @(q, pd) q + alpha * J(q)' * (pd - f(q));

% Prima iterazione per pd1
q1_Newton_I = newtonIteration(q0, pd1);
q1_Gradient_I = gradientIteration(q0, pd1);

% Prima iterazione per pd2
q1_Newton_II = newtonIteration(q0, pd2);
q1_Gradient_II = gradientIteration(q0, pd2);

% Visualizzazione dei risultati
disp('Prima iterazione (Metodo di Newton) per pd1:');
disp(q1_Newton_I);

disp('Prima iterazione (Metodo del Gradiente) per pd1:');
disp(q1_Gradient_I);

disp('Prima iterazione (Metodo di Newton) per pd2:');
disp(q1_Newton_II);

disp('Prima iterazione (Metodo del Gradiente) per pd2:');
disp(q1_Gradient_II);

% Discussione dei risultati al variare di ε
epsilon_values = logspace(-10, -1, 10); % Variazione di ε su scala logaritmica
for eps = epsilon_values
    q0_eps = [pi/4; eps];
    q1_Newton_I_eps = newtonIteration(q0_eps, pd1);
    q1_Gradient_I_eps = gradientIteration(q0_eps, pd1);
    q1_Newton_II_eps = newtonIteration(q0_eps, pd2);
    q1_Gradient_II_eps = gradientIteration(q0_eps, pd2);
    
    fprintf('ε = %e\n', eps);
    fprintf('Newton I: q1 = [%.6f, %.6f]\n', q1_Newton_I_eps);
    fprintf('Gradient I: q1 = [%.6f, %.6f]\n', q1_Gradient_I_eps);
    fprintf('Newton II: q1 = [%.6f, %.6f]\n', q1_Newton_II_eps);
    fprintf('Gradient II: q1 = [%.6f, %.6f]\n', q1_Gradient_II_eps);
end
