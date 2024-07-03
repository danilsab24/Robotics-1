% Definizione delle variabili
theta_x = pi/2 % rotazione intorno all'asse x
theta_z = pi/2 % rotazione intorno all'asse z

% Matrice di rotazione intorno all'asse x
Rx = [1, 0, 0;
      0, cos(theta_x), -sin(theta_x);
      0, sin(theta_x), cos(theta_x)];

% Matrice di rotazione intorno all'asse z
Rz = [cos(theta_z), -sin(theta_z), 0;
      sin(theta_z), cos(theta_z), 0;
      0, 0, 1];

% Calcolo della matrice di rotazione complessiva
R = Rz * Rx
