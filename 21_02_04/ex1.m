clear all
clc

% Definizione dell'asse-angolo r e dell'angolo theta
r = [1/sqrt(3); -1/sqrt(3); 1/sqrt(3)];  % Asse dell'angolo (normalizzato)
theta = pi/6;  % Angolo in radianti

% Calcolo della matrice di rotazione tramite la formula di Rodriguez
K = [0, -r(3), r(2);
     r(3), 0, -r(1);
     -r(2), r(1), 0];  % Matrice di skew-symmetric
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * (K^2);  % Formula di Rodriguez

% Decomposizione della matrice di rotazione in Roll-Pitch-Yaw
beta = asin(-R(3,1));  % Pitch angle
alpha = atan2(R(3,2)/cos(beta), R(3,3)/cos(beta));  % Roll angle
gamma = atan2(R(2,1)/cos(beta), R(1,1)/cos(beta));  % Yaw angle

% Visualizza gli angoli in radianti
disp(['Alpha (Roll): ', num2str(alpha), ' radians']);
disp(['Beta (Pitch): ', num2str(beta), ' radians']);
disp(['Gamma (Yaw): ', num2str(gamma), ' radians']);

