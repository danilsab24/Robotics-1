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
alpha_R1 = atan2(r_21_R1/cos(beta_R1), r_11_R1/cos(beta_R1));
gamma_R1 = atan2(r_32_R1/cos(beta_R1), r_33_R1/cos(beta_R1));

beta_R1_neg = atan2(-r_31_R1, -sqrt((r_32_R1)^2)+(r_33_R1)^2);
alpha_R1_neg = atan2(r_21_R1/cos(beta_R1_neg), r_11_R1/cos(beta_R1_neg));
gamma_R1_neg = atan2(r_32_R1/cos(beta_R1_neg), r_33_R1/cos(beta_R1_neg));

beta_Rvia = atan2(-r_31_Rvia, sqrt((r_32_Rvia)^2)+(r_33_Rvia)^2);
alpha_Rvia = atan2(r_21_Rvia/cos(beta_Rvia), r_11_Rvia/cos(beta_Rvia));
gamma_Rvia = atan2(r_32_Rvia/cos(beta_Rvia), r_33_Rvia/cos(beta_Rvia));

beta_Rvia_neg = atan2(-r_31_Rvia, -sqrt((r_32_Rvia)^2)+(r_33_Rvia)^2);
alpha_Rvia_neg = atan2(r_21_Rvia/cos(beta_Rvia_neg), r_11_Rvia/cos(beta_Rvia_neg));
gamma_Rvia_neg = atan2(r_32_Rvia/cos(beta_Rvia_neg), r_33_Rvia/cos(beta_Rvia_neg));

beta_R2 = atan2(-r_31_R2, sqrt((r_32_R2)^2)+(r_33_R2)^2);
alpha_R2 = atan2(r_21_R2/cos(beta_R2), r_11_R2/cos(beta_R2));
gamma_R2 = atan2(r_32_R2/cos(beta_R2), r_33_R2/cos(beta_R2));

beta_R2_neg = atan2(-r_31_R2, -sqrt((r_32_R2)^2)+(r_33_R2)^2);
alpha_R2_neg = atan2(r_21_R2/cos(beta_R2_neg), r_11_R2/cos(beta_R2_neg));
gamma_R2_neg = atan2(r_32_R2/cos(beta_R2_neg), r_33_R2/cos(beta_R2_neg));

disp("angoli trovati: ")
disp("For R1")
disp("alpha pos: "+alpha_R1)
disp("beta pos: "+beta_R1)
disp("gamma pos: "+gamma_R1)
disp(" ")
disp("alpha neg: "+alpha_R1_neg)
disp("beta neg: "+beta_R1_neg)
disp("gamma neg: "+gamma_R1_neg)
disp(" ")
disp("For R_via")
disp("alpha pos: "+alpha_Rvia)
disp("beta pos: "+beta_Rvia)
disp("gamma pos: "+gamma_Rvia)
disp(" ")
disp("alpha neg: "+alpha_Rvia_neg)
disp("beta neg: "+beta_Rvia_neg)
disp("gamma neg: "+gamma_Rvia_neg)
disp(" ")
disp("For R2")
disp("alpha pos: "+alpha_R2)
disp("beta pos: "+beta_R2)
disp("gamma pos: "+gamma_R2)
disp(" ")
disp("alpha neg: "+alpha_R2_neg)
disp("beta neg: "+beta_R2_neg)
disp("gamma neg: "+gamma_R2_neg)