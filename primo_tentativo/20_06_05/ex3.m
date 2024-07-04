clear all
clc

syms q1 q2 q3

J = [-sin(q1)*(cos(q2) + cos(q2 + q3)), -cos(q1)*(sin(q2) + sin(q2 + q3)), -cos(q1)*sin(q2 + q3)
     cos(q1)*(cos(q2) + cos(q2 + q3)), -sin(q1)*(sin(q2) + sin(q2 + q3)), -sin(q1)*sin(q2 + q3)
                 0,                             cos(q2)+cos(q2 + q3),          cos(q2 + q3)];
det_J = simplify(det(J), Steps=100)

qs1 = [0, pi/2, 0]

J_qs1 = subs(J, [q1, q2, q2], qs1) 

qs2 = [0, 0, pi]

J_qs2 = subs(J, [q1, q2, q2], qs2) 

qnons = [0, pi/2, pi]

J_nons = subs(J, [q1, q2, q2], qnons) 


