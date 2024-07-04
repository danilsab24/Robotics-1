clear all
clc

R_in = [  0.5       0  -sqrt(3)/2;
       -sqrt(3)/2   0     0.5;
           0        1     0];
R_fin = [sqrt(2)/2    -sqrt(2)/2         0;
          -0.5          -0.5      -sqrt(2)/2;
           0.5           0.5      -sqrt(2)/2];

R = simplify(R_in.'*R_fin, steps=100)