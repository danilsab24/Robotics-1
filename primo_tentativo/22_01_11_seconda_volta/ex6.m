clear all
clc

syms q1 q2 a b

p=[a*cos(q1)+b*cos(q1+q2);
   a*sin(q1)+b*sin(q1+q2)]

J = jacobian(p,[q1,q2])

det_J = simplify(det(J),steps=100)

J_I = subs(J,[q1,q2],[0,0])
J_II = subs(J,[q1,q2],[0,pi])