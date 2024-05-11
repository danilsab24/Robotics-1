clear all
clc

% Esempio di utilizzo
R_initial = [0          1     0; 
             0.5        0     sqrt(3)/2; 
             sqrt(3)/2  0     -0.5]
R_final = [1  0 0; 
           0 -1 0;
           0 0 -1]  

[axis, angle] = rotationMatrixToAxisAngle(R_initial, R_final)

function [axis, angle] = rotationMatrixToAxisAngle(R_initial, R_final)
    % Calcola la matrice di rotazione tra R_initial e R_final
    R = R_final * R_initial';
    
    % Calcola l'angolo di rotazione
    angle = acos((trace(R) - 1) / 2);
    
    % Calcola il vettore asse di rotazione
    axis = 1/(2*sin(angle)) * [R(3,2) - R(2,3); R(1,3) - R(3,1); R(2,1) - R(1,2)];
end