clear all
clc

syms alpha beta gamma phi

Ry1 = [cos(alpha), 0,  sin(alpha); 
       0,            1,           0;
      -sin(alpha), 0, cos(alpha)];

Rx = [1,            0,           0; 
      0, cos(beta), -sin(beta); 
      0, sin(beta), cos(beta)];

Ry2 = [cos(gamma), 0,  sin(gamma); 
       0,            1,           0;
      -sin(gamma), 0, cos(gamma)];

R_YXY = simplify(Ry1*Rx*Ry2, steps=100)
R_YXY_subs = eval(subs(R_YXY, [alpha, beta, gamma], [pi/4, -pi/4, pi/3]))

R_0f = [0    sin(phi)  cos(phi);
        0    cos(phi)  -sin(phi);
        -1       0         0]
R_0f = eval(subs(R_0f, phi, pi/3))

R_if = R_YXY_subs.'*R_0f

% Calcolo dell'angolo di rotazione
theta = acos((trace(R_if) - 1) / 2);

% Calcolo dell'asse di rotazione
r = 1/(2*sin(theta)) * [R_if(3,2) - R_if(2,3); R_if(1,3) - R_if(3,1); R_if(2,1) - R_if(1,2)];

% Visualizzazione dei risultati
disp("Rappresentazione asse-angolo (r, θ):");
disp("Asse di rotazione (r):");
disp(r);
disp("Angolo di rotazione (θ):");
disp(theta);