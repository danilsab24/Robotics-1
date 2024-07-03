clear all
clc
syms l1 l2 q1 q2 A D Pdx Pdy C1 S1

% % Definisci l'espressione
% expr = l1*cos(q1) + l2*cos(q1+q2) + l1*sin(q1) + l2*sin(q1+q2);
% 
% expr2 = simplify(-2*((l1*cos(q1)+l2*cos(q1+q2))*(l1*sin(q1)+l2*sin(q1+q2))), steps=1000)
% 
% % Calcola il quadrato dell'espressione
% expr_squared = simplify(expand(expr^2), steps=1000);
% 
% expr_final = simplify(expr_squared - expr2, steps=1000);
% 
% % Visualizza il risultato
% disp('Il quadrato dell''espressione è:')
% disp(expr_squared)
% disp('espressione finale:')
% disp(expr_final)

eq1 = D*(sin(q1)*sin(q2)-cos(q1)*cos(q2)) + A*cos(q1) == Pdx
eq2 = D*(sin(q1)*cos(q2)+cos(q1)*sin(q2)) + A*sin(q1) == Pdy

eq1_subs = subs(eq1, [cos(q1),sin(q1)], [C1,S1])
eq2_subs = subs(eq2, [cos(q1),sin(q1)], [C1,S1])

% Risolvere le equazioni per C1 (cos(q1)) e S1 (sin(q1))
sol = solve([eq1_subs, eq2_subs], [C1, S1]);

% Visualizzare le soluzioni
cos_q1 = simplify(sol.C1, steps=1000);
sin_q1 = simplify(sol.S1,steps=1000);

disp('La soluzione per cos(q1) è:');
disp(cos_q1);
disp('La soluzione per sin(q1) è:');
disp(sin_q1);