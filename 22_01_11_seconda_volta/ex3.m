clear all
clc

syms q1 q2 q3 K D 

p = [K*cos(q1) + D*cos(q1+q3) - q2*sin(q1);
     K*sin(q1) + D*sin(q1+q3) + q2*cos(q1);
               q1+q3];

J = simplify(jacobian(p,[q1,q2,q3]),steps=100)

det_J = simplify(det(J), steps=100)

J_subs = subs(J,q2,0)

NULL_SPACE_J_subs = null(J_subs)

% per calcolare il range space bisogna trovare i vettori linearmente
% indipendi della matri può capitare che colspace non funziona per tale
% motivo utilizzo rref che mi trova la forma ridotta della matrici in modo
% che so quali sono i vettori linearmente indipendi
% Calcolare la forma ridotta per righe (RREF) della matrice
rref_matrix = rref(J_subs)

J_subs_subs = subs(J_subs,[K,D],[1,sqrt(2)])

r_dot = [-sin(q1);
          cos(q1);
            0];
q_dot = simplify(pinv(J_subs)*r_dot,steps=100)