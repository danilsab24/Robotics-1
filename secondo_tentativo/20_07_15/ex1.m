clear all
clc

% Angolo di rotazione
theta_z = pi/2;
theta_x = pi/2;

% Matrice di rotazione intorno all'asse z
Rz = [cos(theta_z), -sin(theta_z), 0;
      sin(theta_z),  cos(theta_z), 0;
      0,            0,            1];

% Matrice di rotazione intorno all'asse x
Rx = [1, 0,            0;
      0, cos(theta_x), -sin(theta_x);
      0, sin(theta_x),  cos(theta_x)];

% Prodotto delle due matrici di rotazione
R = Rz * Rx;

% Visualizza il risultato
disp('La matrice risultante dal prodotto delle due matrici di rotazione è:')
disp(R)
