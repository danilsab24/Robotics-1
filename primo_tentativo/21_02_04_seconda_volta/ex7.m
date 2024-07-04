clc
clear all

syms s t T_time alfa beta gamma Ca0 Ca1 Ca2 Ca3 Ca4 Ca5 tau phi_in phi_f phi_vel_in

%usiamo questo metodo Euler
R_in_0 = [0.5 , 0 , -sqrt(3)/2;
        -sqrt(3)/2, 0 , -0.5;
        0,      1 ,       0];

R_fin_T = [sqrt(2)/2 , -sqrt(2)/2 , 0;
           -0.5 , -0.5 , -sqrt(2)/2;
           0.5 , 0.5 , -sqrt(2)/2];

[phi_0_1, phi_0_2] = rotm2eul(R_in_0, "XYZ")
[phi_T_1, phi_T_2] = rotm2eul(R_fin_T, "XYZ")

omega = [3 ; -2 ; 1]

R_x = [1       0        0;
       0    cos(alfa)   -sin(alfa);
       0    sin(alfa)    cos(alfa)];

R_y = [cos(beta)     0   sin(beta);
        0	    1     0;
       -sin(beta)     0   cos(beta)];

R_z = [cos(gamma)  -sin(gamma)    0;
           sin(gamma)   cos(gamma)    0;
             0        0       1];

R_xy = R_x * R_y

R_x_2 = [0 ; cos(alfa); sin(alfa)];

R_xy_3 = [sin(beta); -sin(alfa) * cos(beta); cos(alfa)*cos(beta)]

vector = [1; 0; 0]

T = [vector,  R_x_2, R_xy_3]