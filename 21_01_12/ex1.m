clear all
clc

syms alpha beta gamma a

% Rotation matrix around X axis
R_x = [1, 0, 0;
      0, cos(beta), -sin(beta);
      0, sin(beta), cos(beta)];

% Rotation matrix around Y axis
R_Y = [cos(alpha), 0, sin(alpha);
      0, 1, 0;
      -sin(alpha), 0, cos(alpha)];

% Rotation matrix around Z axis
R_Z = [cos(gamma), -sin(gamma), 0;
      sin(gamma), cos(gamma), 0;
      0, 0, 1];

R_YXZ = simplify(R_Y*R_x*R_Z, steps=100)

% Matrice di rotazione R (da specificare)
R = [0         1  0; 
    0.5        0  sqrt(3)/2; 
    sqrt(3)/2  0  -0.5];

R_13 = R(1,3);
R_33 = R(3,3);
R_23 = R(2,3);
R_21 = R(2,1);
R_22 = R(2,2);

beta_pos = atan2(-R_23, +sqrt((R_13)^2+(R_33)^2));
beta_neg = atan2(-R_23, -sqrt((R_13)^2+(R_33)^2));

alpha_pos = atan2(R_13/cos(beta_pos), R_33/cos(beta_pos));
alpha_neg = atan2(R_13/cos(beta_neg), R_33/cos(beta_neg));

gamma_pos = atan2(R_21/cos(beta_pos), R_22/cos(beta_pos));
gamma_neg = atan2(R_21/cos(beta_neg), R_22/cos(beta_neg));

disp("alpha 1: "+ alpha_pos);
disp("beta 1: "+ beta_pos)
disp("gamma 1: "+ gamma_pos)
disp("  ")
disp("alpha 2: "+ alpha_neg)
disp("beta 2: "+ beta_neg)
disp("gamma 2: "+ gamma_neg)


