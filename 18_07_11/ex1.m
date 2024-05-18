clear all
clc 

syms alpha beta gamma

%punto a
R_y = [cos(alpha), 0, sin(alpha);
       0,          1, 0;
       -sin(alpha), 0, cos(alpha)];

R_x = [1, 0,          0;
       0, cos(beta), -sin(beta);
       0, sin(beta), cos(beta)];

R_z = [cos(gamma), -sin(gamma), 0;
       sin(gamma), cos(gamma),  0;
       0,          0,           1];

R_YXZ = simplify(R_z*R_x*R_y, steps=100)

det_R_YXZ = simplify(det(R_YXZ), steps=100)

%punto b 
%inutile 
R_YXZ_subs = subs(R_YXZ, beta, pi/2)
det_R_YXZ_subs = simplify(det(R_YXZ_subs), steps=100)

%punto d
J = simplify(jacobian(R_YXZ, [alpha, beta, gamma]), steps=100)