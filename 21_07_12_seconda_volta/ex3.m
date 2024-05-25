clear all
clc

syms alpha beta gamma

R_1 = [0   -sqrt(2)/2   sqrt(2)/2;
       1    0           0;
       0    sqrt(2)/2   sqrt(2)/2]

R_2 = [sqrt(2)/2   1/2         -1/2;
          0       -sqrt(2)/2   -sqrt(2)/2;
       -sqrt(2)/2  1/2           -1/2]

R_via = [ sqrt(6)/4     sqrt(2)/4  -sqrt(2)/2;
         -sqrt(6)/4    -sqrt(2)/4  -sqrt(2)/2;
         -1/2           sqrt(3)/2      0]

r_11_R1 = R_1(1,1)

r_21_R1 = R_1(2,1)

r_31_R1 = R_1(3,1)
r_32_R1 = R_1(3,2)
r_33_R1 = R_1(3,3)

r_11_R2 = R_2(1,1)

r_21_R2 = R_2(2,1)

r_31_R2 = R_2(3,1)
r_32_R2 = R_2(3,2)
r_33_R2 = R_2(3,3)

r_11_Rvia = R_via(1,1)

r_21_Rvia = R_via(2,1)

r_31_Rvia = R_via(3,1)
r_32_Rvia = R_via(3,2)
r_33_Rvia = R_via(3,3)

Rx = [1, 0, 0;
      0, cos(gamma), -sin(gamma);
      0, sin(gamma), cos(gamma)];

Ry = [cos(beta), 0, sin(beta);
      0, 1, 0;
      -sin(beta), 0, cos(beta)];

Rz = [cos(alpha), -sin(alpha), 0;
      sin(alpha), cos(alpha), 0;
      0, 0, 1];

R_ZYX = simplify(Rz*Ry*Rx, steps=100)

beta_R1 = atan2(-r_31_R1, sqrt((r_32_R1)^2)+(r_33_R1)^2);
alpha_R1 = atan2(r_21_R1/cos(beta), r_11_R1/cos(beta));
gamma_R1 = atan2(r_32_R1/cos(beta), r_33_R1/cos(beta));

beta_Rvia = atan2(-r_31_Rvia, sqrt((r_32_Rvia)^2)+(r_33_Rvia)^2);
alpha_Rvia = atan2(r_21_Rvia/cos(beta), r_11_Rvia/cos(beta));
gamma_Rvia = atan2(r_32_Rvia/cos(beta), r_33_Rvia/cos(beta));

beta_R2 = atan2(-r_31_R2, sqrt((r_32_R2)^2)+(r_33_R2)^2);
alpha_R2 = atan2(r_21_R2/cos(beta), r_11_R2/cos(beta));
gamma_R2 = atan2(r_32_R2/cos(beta), r_33_R2/cos(beta));

disp("angoli trovati: ")
disp("alpha for R1: "+alpha_R1)
disp("beta for R1: "+beta_R1)
disp("gamma for R1: "+gamma_R1)
disp(" ")
disp("alpha for Rvia: "+alpha_Rvia)
disp("beta for Rvia: "+beta_Rvia)
disp("gamma for Rvia: "+gamma_Rvia)
disp(" ")
disp("alpha for R2: "+alpha_R2)
disp("beta for R2: "+beta_R2)
disp("gamma for R2: "+gamma_R2)