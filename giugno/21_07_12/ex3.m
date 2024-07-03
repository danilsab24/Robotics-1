clear all
clc

syms alpha beta gamma

R_y = [cos(alpha), 0, sin(alpha);
       0, 1, 0;
       -sin(alpha), 0, cos(alpha)];
   
R_x = [1, 0, 0;
       0, cos(beta), -sin(beta);
       0, sin(beta), cos(beta)];
   
R_z = [cos(gamma), -sin(gamma), 0;
       sin(gamma), cos(gamma), 0;
       0, 0, 1];

R_ZYX = simplify(R_z*R_y*R_x, steps=100)