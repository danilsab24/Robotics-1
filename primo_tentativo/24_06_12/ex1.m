clear all
clc

syms alpha beta gamma alpha_dot beta_dot gamma_dot 

omega_i = [0;1;0]
omega_f = [0;0;1]

%MATRICI DI EULERO ZXZ
R_Z1 = [cos(alpha)   -sin(alpha)  0;
        sin(alpha)    cos(alpha)  0;
            0             0       1]

R_x = [1       0           0;
       0    cos(beta)  -sin(beta);
       0    sin(beta)   cos(beta)]

R_Z2 = [cos(gamma)   -sin(gamma)  0;
        sin(gamma)    cos(gamma)  0;
            0             0       1]
%matrici iniziali e finali
R_i = [0   0   1;
       0   1   0;
       -1  0   0]

R_f = [sqrt(2)/2    0     sqrt(2)/2;
       sqrt(2)/2    0    -sqrt(2)/2;
           0        1       0]

R_ZXZ = simplify(R_Z1*R_x*R_Z2, steps=100)

r_13_i = R_i(1,3)
r_23_i = R_i(2,3)
r_31_i = R_i(3,1)
r_32_i = R_i(3,2)
r_33_i = R_i(3,3)

r_13_f = R_f(1,3)
r_23_f = R_f(2,3)
r_31_f = R_f(3,1)
r_32_f = R_f(3,2)
r_33_f = R_f(3,3)

beta_i_pos = atan2(+sqrt((r_13_i)^2+(r_23_i)^2),r_33_i)
beta_i_neg = atan2(-sqrt((r_13_i)^2+(r_23_i)^2),r_33_i)
alpha_i_pos = atan2(r_13_i/sin(beta_i_pos), -r_23_i/sin(beta_i_pos))
alpha_i_neg = atan2(r_13_i/sin(beta_i_neg), -r_23_i/sin(beta_i_neg))
gamma_i_pos = atan2(r_31_i/sin(beta_i_pos), r_32_i/sin(beta_i_pos))
gamma_i_neg = atan2(r_31_i/sin(beta_i_neg), r_32_i/sin(beta_i_neg))

beta_f_pos = atan2(+sqrt((r_13_f)^2+(r_23_f)^2),r_33_f)
beta_f_neg = atan2(-sqrt((r_13_f)^2+(r_23_f)^2),r_33_f)
alpha_f_pos = atan2(r_13_f/sin(beta_f_pos), -r_23_f/sin(beta_f_pos))
alpha_f_neg = atan2(r_13_f/sin(beta_f_neg), -r_23_f/sin(beta_f_neg))
gamma_f_pos = atan2(r_31_f/sin(beta_f_pos), r_32_f/sin(beta_f_pos))
gamma_f_neg = atan2(r_31_f/sin(beta_f_neg), r_32_f/sin(beta_f_neg))

disp("angoli initial:")
disp("alpha pos: "+ alpha_i_pos)
disp("alpha neg: "+ alpha_i_neg)
disp("beta pos: "+ beta_i_pos)
disp("beta neg: "+ beta_i_neg)
disp("gamma pos: "+ gamma_i_pos)
disp("gamma neg: "+ gamma_i_neg)
disp(" ")
disp("angoli final:")
disp("alpha pos: "+ alpha_f_pos)
disp("alpha neg: "+ alpha_f_neg)
disp("beta pos: "+ beta_f_pos)
disp("beta neg: "+ beta_f_neg)
disp("gamma pos: "+ gamma_f_pos)
disp("gamma neg: "+ gamma_f_neg)


%relation between phi_dot and omega
omega = [[1;0;0]  R_Z1*[0;1;0]  R_Z1*R_x*[0;0;1]]
