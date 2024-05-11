clc
clear all

% Angoli di Eulero (in radianti)
phi = -pi/2;  % Rotazione attorno all'asse Z
theta = -pi/4;  % Rotazione attorno all'asse Y
psi = pi/4;  % Rotazione attorno all'asse X

% Matrici di rotazione di Eulero
Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1]
Ry = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)]
Rx = [1 0 0; 0 cos(psi) -sin(psi); 0 sin(psi) cos(psi)]

% Applicazione delle rotazioni
R = Rx * Ry * Rz

% V = colonna contentente l'autovettore corrispondente all'autovalore che è
% in D
[V,D] = eig(R)