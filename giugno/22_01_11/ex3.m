clear all
clc 

syms a1 a2 a3 K D

%punto i

p = [K*cos(a1) + D*cos(a1 + a3) - a2*sin(a1);
     K*sin(a1) + D*sin(a1 + a3) + a2*cos(a1);
     a1 + a3]
J = simplify(jacobian(p, [a1, a2, a3]), Steps=100)

%punto ii

det_J = simplify(det(J), Steps=100)

%punto iii

J_0 = subs(J, a2, 0)

N = null(J_0)

grado = rank(J_0)

% R = colspace(J_0)  -> calcolata a mano ricorda -> range space = immagine
% di una matrice -> sono le colonne indipendenti

%punto iv

r_dot = [-sin(a1); cos(a1); 0]

J_0_subs = subs(J_0, [K,D], [1,sqrt(2)])

J_0_inv = simplify(pinv(J_0_subs), steps=100)

q_dot = simplify(J_0_inv*r_dot, steps=100)
