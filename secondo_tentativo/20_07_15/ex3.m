clear all
clc

% Angoli di rotazione (in radianti)
syms alpha beta gamma

% Matrice di rotazione intorno all'asse Y (prima rotazione)
Ry1 = [cos(alpha), 0, sin(alpha);
       0, 1, 0;
       -sin(alpha), 0, cos(alpha)];

% Matrice di rotazione intorno all'asse X (seconda rotazione)
Rx = [1, 0, 0;
      0, cos(beta), -sin(beta);
      0, sin(beta), cos(beta)];

% Matrice di rotazione intorno all'asse Y (terza rotazione)
Ry2 = [cos(gamma), 0, sin(gamma);
       0, 1, 0;
       -sin(gamma), 0, cos(gamma)];

% Prodotto delle matrici di rotazione nell'ordine YXY
R = simplify(Ry1 * Rx * Ry2)


