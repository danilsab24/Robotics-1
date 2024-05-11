clc
clear all

syms q1 q2 q3
R_Y = [ cos(q1),   0,   sin(q1); 
              0,   1,          0; 
        -sin(q1),   0,     cos(q1)]

R_X = [1,        0,        0; 
       0,  cos(q2),  sin(q2); 
       0,  sin(q2),  cos(q2)]
R_Y2 = [ cos(q3),   0,   sin(q3); 
              0,   1,          0; 
        -sin(q3),   0,     cos(q3)]

R_YXY = R_Y*R_X*R_Y2


R_initial = [ 0,       0.5, -sqrt(3)/2; 
             -1,         0,          0; 
              0, sqrt(3)/2,        0.5]

R_final = [1,  0, 0; 
           0,  0, 1; 
           0, -1, 0]

R_initial_final = R_initial.'*R_final 

% Trova gli angoli nella rappresentazione YXY
angles_YXY = find_angles_YXY(R_initial_final, R_YXY)

% Funzione per calcolare la differenza tra due matrici di rotazione
function difference = rotation_difference(R1, R2)
    difference = norm(reshape(R1 - R2, [], 1));
end

% Funzione per trovare gli angoli nella rappresentazione YXY che soddisfano la matrice di rotazione composta
function angles = find_angles_YXY(R_composed, R_YXY)
    options = optimset('Display','off');
    % Funzione obiettivo per minimizzare la differenza tra le due matrici di rotazione
    objective = @(angles) rotation_difference(R_composed, compose_YXY_rotation(angles))^2;
    % Valori iniziali degli angoli (puoi iniziare con valori casuali)
    initial_angles = [0, 0, 0];
    % Risoluzione tramite minimizzazione della funzione obiettivo
    angles = fminsearch(objective, initial_angles, options);
end

% Funzione per comporre una matrice di rotazione YXY data una serie di angoli
function R = compose_YXY_rotation(angles)
    theta1 = angles(1);
    theta2 = angles(2);
    theta3 = angles(3);
    
    % Matrici di rotazione per le tre rotazioni YX
    R1 = [cos(theta1), 0, sin(theta1); 0, 1, 0; -sin(theta1), 0, cos(theta1)];
    R2 = [cos(theta2), -sin(theta2), 0; sin(theta2), cos(theta2), 0; 0, 0, 1];
    R3 = [cos(theta3), 0, sin(theta3); 0, 1, 0; -sin(theta3), 0, cos(theta3)];
    
    % Composizione delle rotazioni YXY
    R = R3 * R2 * R1;
end


