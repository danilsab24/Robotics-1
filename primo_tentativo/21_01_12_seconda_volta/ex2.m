clear all
clc

R = [0          1    0;
     0.5        0    sqrt(3)/2;
     sqrt(3)/2  0    -0.5]

omega = R*[1; -1; 0]

S_omega = [    0      -omega(3)   omega(2);
            omega(3)      0      -omega(1);
           -omega(2)   omega(1)      0  ]

R_dot = S_omega*R