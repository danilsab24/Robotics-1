clc
clear all

R_A = [0 1  0;
       1 0  0;
       0 0 -1]
R_B = [-1/sqrt(2)  0       1/sqrt(2);
       0         -1       0;
       1/sqrt(2)   0       1/sqrt(2)]
R_AB = R_A.'*R_B

r_11 = R_AB(1,1)
r_12 = R_AB(1,2)
r_13 = R_AB(1,3)
r_21 = R_AB(2,1)
r_22 = R_AB(2,2)
r_23 = R_AB(2,3)
r_31 = R_AB(3,1)
r_32 = R_AB(3,2)
r_33 = R_AB(3,3)

theta = atan2(sqrt((r_12 - r_21)^(2) + (r_13 - r_31)^(2) + (r_23 - r_32)^(2)), r_11 + r_22 + r_33 -1)

matr = [r_32 - r_23;
        r_13 - r_31;
        r_21 - r_12];

r = (1/(2*sin(theta)))*matr

