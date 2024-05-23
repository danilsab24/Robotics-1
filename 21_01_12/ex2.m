clear all
clc

% Definizione del vettore
vettore = [1; -1; 0];

% Costruzione della matrice skew-symmetric
matrice_skew = [0, -vettore(3), vettore(2);
                vettore(3), 0, -vettore(1);
                -vettore(2), vettore(1), 0];

R = [0         1  0; 
    0.5        0  sqrt(3)/2; 
    sqrt(3)/2  0  -0.5];

R_dot = R*matrice_skew
