clear all
clc

syms alpha beta gamma

R_x = [1, 0, 0;
       0, cos(alpha), -sin(alpha);
       0, sin(alpha), cos(alpha)];

% Matrice di rotazione per il beccheggio (Y)
R_y = [cos(beta), 0, sin(beta);
       0, 1, 0;
       -sin(beta), 0, cos(beta)];
   
% Matrice di rotazione per l'imbardata (Z)
R_z = [cos(gamma), -sin(gamma), 0;
       sin(gamma), cos(gamma), 0;
       0, 0, 1];

%fixed axis
R_ZYX = simplify(R_z*R_y*R_x, steps=100)

% Dati del problema
r = [1/sqrt(3), -1/sqrt(3), 1/sqrt(3)];
theta = pi/6;

% Calcolo della matrice di rotazione
R = rotation_matrix(r, theta);

disp('Matrice di rotazione:');
disp(R);

r_11 = R(1,1);
r_21 = R(2,1);
r_31 = R(3,1);
r_32 = R(3,2);
r_33 = R(3,3);

beta_pos = atan2(-r_31, +sqrt((r_32)^2+(r_33)^2));
beta_neg = atan2(-r_31, -sqrt((r_32)^2+(r_33)^2));

alpha_pos = atan2(r_32/cos(beta_pos), r_33/(cos(beta_pos)));
alpha_neg = atan2(r_32/cos(beta_neg), r_33/(cos(beta_neg)));

gamma_pos = atan2(r_21/cos(beta_pos), r_11/(cos(beta_pos)));
gamma_neg = atan2(r_21/cos(beta_neg), r_11/(cos(beta_neg)));

disp("angles found")
disp("alpha_I: "+alpha_pos)
disp("beta_I: "+beta_pos)
disp("gamma_I: "+gamma_pos)
disp(" ")
disp("alpha_II: "+alpha_neg)
disp("beta_II: "+beta_neg)
disp("gamma_II: "+gamma_neg)

disp("control of correctness")
R_contr = R_ZYX
R_contr_subs_I = eval(subs(R_ZYX,[alpha,beta,gamma],[alpha_pos,beta_pos,gamma_pos]))
R_contr_subs_II = eval(subs(R_ZYX,[alpha,beta,gamma],[alpha_neg,beta_neg,gamma_neg]))

% Dati del problema
r = [1/sqrt(3), -1/sqrt(3), 1/sqrt(3)];
theta = pi/6;

% Calcolo degli angoli RPY e verifica delle singolarità
[alpha, beta, gamma, singularity] = find_rpy_and_singularities(r, theta);

disp(['Singolarità: ', num2str(singularity)]);

function R = rotation_matrix(r, theta)
    % Calcola la matrice di rotazione attorno ad un asse arbitrario
    % r     - vettore unitario (asse di rotazione)
    % theta - angolo di rotazione in radianti
    
    % Matrice identità
    I = eye(3);
    
    % Matrice antisimmetrica K costruita da r
    K = [  0,     -r(3),  r(2);
          r(3),   0,    -r(1);
         -r(2),  r(1),   0   ];
    
    % Matrice di rotazione
    R = I + sin(theta) * K + (1 - cos(theta)) * K^2;
end

function [alpha, beta, gamma, singularity] = find_rpy_and_singularities(r, theta)
    % Funzione per calcolare gli angoli RPY e le singolarità
    % r     - vettore unitario (asse di rotazione)
    % theta - angolo di rotazione in radianti
    
    % Matrice identità
    I = eye(3);
    
    % Matrice antisimmetrica K costruita da r
    K = [  0,     -r(3),  r(2);
          r(3),   0,    -r(1);
         -r(2),  r(1),   0   ];
    
    % Matrice di rotazione
    R = I + sin(theta) * K + (1 - cos(theta)) * K^2;
    
    % Conversione della matrice di rotazione in angoli RPY
    beta = asin(-R(3,1));  % Calcolo di β (pitch)
    
    if abs(beta - pi/2) < 1e-6
        % Singolarità per β = π/2
        alpha = 0;
        gamma = atan2(R(1,2), R(2,2));
        singularity = true;
    elseif abs(beta + pi/2) < 1e-6
        % Singolarità per β = -π/2
        alpha = 0;
        gamma = -atan2(R(1,2), R(2,2));
        singularity = true;
    else
        % Calcolo di α (roll) e γ (yaw)
        alpha = atan2(R(3,2), R(3,3));
        gamma = atan2(R(2,1), R(1,1));
        singularity = false;
    end
end

