clear all 
clc

syms alpha beta gamma

% Matrice di rotazione intorno all'asse Y (angolo alpha)
RY = [ cos(alpha)  0  sin(alpha);
           0        1      0    ;
      -sin(alpha) 0  cos(alpha)];

% Matrice di rotazione intorno all'asse X (angolo beta)
RX = [ 1      0            0 ;
       0 cos(beta) -sin(beta);
       0 sin(beta)  cos(beta)];

% Matrice di rotazione intorno all'asse Z (angolo gamma)
RZ = [ cos(gamma) -sin(gamma)    0;
       sin(gamma)  cos(gamma)    0;
           0              0      1];

R_YXZ = simplify(RY*RX*RZ, steps=100)

R = [0          1    0;
     0.5        0    sqrt(3)/2;
     sqrt(3)/2  0    -0.5]

r_11 = R(1,1);
r_12 = R(1,2);
r_13 = R(1,3);
r_21 = R(2,1);
r_22 = R(2,2);
r_23 = R(2,3);
r_31 = R(3,1);
r_32 = R(3,2);
r_33 = R(3,3);

beta_pos = atan2(-r_23, +sqrt((r_13)^2+(r_33)^2));
beta_neg = atan2(-r_23, -sqrt((r_13)^2+(r_33)^2));
gamma_pos = atan2(r_21/cos(beta_pos),r_22/(cos(beta_pos)));
gamma_neg = atan2(r_21/cos(beta_neg),r_22/(cos(beta_neg)));
alpha_pos = atan2(r_13/cos(beta_pos), r_33/cos(beta_pos));
alpha_neg = atan2(r_13/cos(beta_neg), r_33/cos(beta_neg));
disp("angoli trovati: ")
disp("alpha I: "+alpha_pos)
disp("beta I: "+beta_pos)
disp("gamma I: "+gamma_pos)
disp("alpha II: "+alpha_neg)
disp("beta II: "+beta_neg)
disp("gamma II: "+gamma_neg)
