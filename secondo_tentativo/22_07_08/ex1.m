clear all 
clc

syms alpha beta gamma alpha_dot beta_dot gamma_dot

phi_dot = [alpha_dot; beta_dot; gamma_dot]

% Matrice di rotazione attorno all'asse X
Rx = [1    0           0;
      0    cos(alpha)   -sin(alpha);
      0    sin(alpha)    cos(alpha)];

% Matrice di rotazione attorno all'asse Z
Rz = [cos(beta)   -sin(beta)   0;
      sin(beta)    cos(beta)   0;
      0             0            1];

% Matrice di rotazione attorno all'asse Y
Ry = [cos(gamma)   0   sin(gamma);
      0            1   0;
      -sin(gamma)  0   cos(gamma)];

% Prodotto delle matrici di rotazione XZY
R = Ry * Rz * Rx

R_I = Ry * Rz

omega = [0;phi_dot(3);0]+Ry*[0;0;phi_dot(2)]+R_I*[phi_dot(1);0;0]

matr = [cos(beta)*cos(gamma) sin(gamma)  0;
         sin(beta)              0        1;
        -cos(beta)*cos(gamma) cos(gamma) 0];

prova = matr*phi_dot

omega_subs = subs(omega, beta, pi/2)
