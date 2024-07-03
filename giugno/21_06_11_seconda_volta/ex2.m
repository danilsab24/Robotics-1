clear all
clc

syms q1 q2 q3 L

p = [q2*cos(q1)+L*cos(q1+q3);
     q2*sin(q1)+L*sin(q1+q3);
     q1+q3]

pdx = 2;
pdy = 0.4;

J = jacobian(p,[q1,q2,q3])

v = [0;-2.5;0];

% p2 = valore del prismatic 
p2 = sqrt((2)^2+(.6+0.4)^2)

% Espressioni per le equazioni
expr1 = subs(q2*cos(q1) + L*cos(q1+q3), [q2, L], [p2, 0.6]) == pdx;
expr2 = subs(q2*sin(q1) + L*sin(q1+q3), [q2, L], [p2, 0.6]) == pdy;

% Risolvere le equazioni
sol = solve([expr1, expr2], [q1, q3]);

% Visualizzare i risultati
disp("Valori dei joints: ")
disp(eval(sol.q1))
disp(p2)
disp(eval(sol.q3))

p1d = eval(sol.q1(2))
p3d = eval(sol.q3(2))

J_subs = eval(subs(J, [q1,q2,q3,L],[p1d,p2,p3d,0.6]))

q_dot = inv(J_subs)*v

% task 2
tau_resist = [-6;0;0]
F_resist = [-15;0;-6]
tau = J_subs.'*F_resist