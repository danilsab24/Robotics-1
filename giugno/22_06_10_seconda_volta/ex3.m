clear all
clc

syms q1 q2 q1_dot q2_dot

p = [q2*cos(q1);
     q2*sin(q1)]

J = simplify(jacobian(p,[q1,q2]),steps=100)

tau_1 = 10;
tau_2 = 5;

F_1 = eval(subs(simplify(inv(-J.')*[tau_1;tau_2]),[q1,q2],[pi/3,1.5]))
F_2 = eval(subs(simplify(inv(-J.')*[-tau_1;tau_2]),[q1,q2],[pi/3,1.5]))
F_3 = eval(subs(simplify(inv(-J.')*[tau_1;-tau_2]),[q1,q2],[pi/3,1.5]))
F_4 = eval(subs(simplify(inv(-J.')*[-tau_1;-tau_2]),[q1,q2],[pi/3,1.5]))