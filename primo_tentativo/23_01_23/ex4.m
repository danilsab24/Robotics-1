clear all
clc

syms q1 q2 q3 q4

%punto a

r = [q2*cos(q1) + q4*cos(q1+q3);
     q2*sin(q1) + q4*sin(q1+q3);
              q1+q3]
J_r = simplify(jacobian(r, [q1,q2,q3, q4]), steps=100)

%punto c

null_J_r_all = simplify(null(J_r), steps=1000)

%punto b

J_r_subs = subs(J_r, [q2,q3], [0,0])
null_J_r = simplify(null(J_r_subs), steps=100)

%punt d

null_J_r_T = simplify(null(J_r_subs.'), steps=100)

% non serve ai fini dell'esercizio
% det_J_r = simplify(det(J_r*J_r.'), steps=100)
% 
% funzione = @(x) [2*sin(x(2))^2 - x(1)^2*sin(x(2))^2 + 2*x(1)^2; 0];
% 
% guess_iniziale = [1; 0];
% 
% soluzione = fsolve(funzione, guess_iniziale);
% 
% disp('Soluzione:');
% disp(soluzione);