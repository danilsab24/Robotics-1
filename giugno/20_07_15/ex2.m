clear all
clc

syms alpha beta gamma

rot_y_1 = [cos(alpha), 0, sin(alpha);
         0, 1, 0;
         -sin(alpha), 0, cos(alpha);]

rot_x = [1, 0, 0;
         0, cos(beta), -sin(beta);
         0, sin(beta), cos(beta);]

rot_y_2 = [cos(gamma), 0, sin(gamma);
         0, 1, 0;
         -sin(gamma), 0, cos(gamma);]

rot_yxy = rot_y_1*rot_x*rot_y_2

rot_yx = rot_y_1*rot_x

T = [0 cos(alpha) sin(alpha)*sin(beta)
     1 0          cos(beta)
     0 -sin(alpha) cos(alpha)*sin(beta)]

det_T = simplify(det(T), Steps=1000)