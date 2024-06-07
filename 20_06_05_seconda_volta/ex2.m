clear all
clc

syms q1 q2 q3 L1

p = [L1*cos(q1)+q3*cos(q1+q2);
     L1*sin(q1)+q3*sin(q1+q2);
           q1+q2]

J = jacobian(p, [q1,q2,q3])

det_J = simplify(det(J),steps=100)

J_sub = subs(J, [L1,q1,q2,q3], [0.5,pi/2,0,3])

F = [0; 1.5; -4.5]

tau_1 = eval(-(J_sub.'*F))

J_sub_2 = subs(J, [L1,q1,q2,q3], [0.5,pi/2,pi/2,3])

tau_2 = eval(-(J_sub_2.'*F))