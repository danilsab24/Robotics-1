clear all
clc

% direct kinematics PRR robot
syms q1 L q2 q3 F_x F_y M_z px py l2 l3 alfa
p_x = q1 + L*cos(q2) + L*cos(q2 + q3)
p_y = L*sin(q2) + L*sin(q2 + q3)
phi = q2 + q3

% jacobian
J = [diff(p_x, q1) diff(p_x, q2) diff(p_x, q3);
     diff(p_y, q1) diff(p_y, q2) diff(p_y, q3);
     diff(phi, q1) diff(phi, q2) diff(phi, q3)];
J = simplify(J, Steps=100)

det_J = det(J)

% consider as singularitie pi/2

J_subs = simplify(subs(J, q2, pi/2), Steps=100)

null_space = null(J_subs)

range_space = colspace(J_subs)

r_1_dot = [1; 0; 0]
q_1_dot = simplify(pinv(J_subs)*r_1_dot, Steps=100)

r_2_dot = [1; 0; 1]
q_2_dot = simplify(pinv(J_subs)*r_2_dot, Steps=100)

F = [F_x; F_y; M_z]
tau = -(J.'*F)

% punto c

risolvi_sistema()

function soluzione = risolvi_sistema()
    % Definizione delle equazioni
    funzioni = @(x) [x(1) + 0.5*cos(x(2) + x(3)) + 0.5*cos(x(2)) - 0.3;
                     0.5*sin(x(2) + x(3)) + 0.5*sin(x(2)) - 0.7;
                     x(2) + x(3) - (pi/3)];

    % Guess iniziale per le variabili q1, q2, q3
    x0 = [0; 0; 0];

    % Risoluzione del sistema di equazioni
    options = optimoptions('fsolve','Display','iter');
    sol = fsolve(funzioni, x0, options);

    % Stampa dei valori dei risultati in un vettore colonna
    soluzione = sol';
end

%punto d
% codice per il disegno del workspace ma non so se sia giusto
% % Parametri del robot PRR
% L1 = 1; % Lunghezza massima del primo giunto prismatico
% L2 = 2; % Lunghezza del primo braccio rotante
% L3 = 2; % Lunghezza del secondo braccio rotante
% 
% % Definizione dell'intervallo dei giunti
% d_range = linspace(0, L1, 100); % Lunghezza del primo giunto prismatico
% theta1_range = linspace(0, pi*2, 100); % Angolo per la giunzione rotante
% 
% % Inizializzazione delle coordinate del workspace
% x_workspace = [];
% y_workspace = [];
% 
% % Calcolo del workspace
% for d = d_range
%     for theta1 = theta1_range
%         % Controlla le singolarità
%         if abs(theta1 - pi/2) < eps || abs(theta1 + pi/2) < eps
%             % Evita di calcolare le singolarità
%             continue;
%         end
% 
%         x = d*cos(theta1) + L2*cos(theta1) + L3*cos(theta1);
%         y = d*sin(theta1) + L2*sin(theta1) + L3*sin(theta1);
%         x_workspace = [x_workspace, x];
%         y_workspace = [y_workspace, y];
%     end
% end
% 
% % Disegno del workspace
% plot(x_workspace, y_workspace, 'b.');
% xlabel('X');
% ylabel('Y');
% title('Workspace del robot PRR');
% axis equal;

