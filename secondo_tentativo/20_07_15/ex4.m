clear all
clc

syms q1 q2 q3 l 

p = [l*cos(q1)+l*cos(q1+q2)+l*cos(q1+q2+q3);
     l*sin(q1)+l*sin(q1+q2)+l*sin(q1+q2+q3);
     q1+q2+q3];

J = simplify(jacobian(p,[q1,q2,q3]),steps=100)

A = [3;2.5];
B = [0.75;1.8];

eq1 = p(1)==-0.4774;
eq2 = p(2)==-0.1485;
eq3 = p(3)== 0;

sol = solve([eq1,eq2,eq3],[q1,q2,q3])
sol_I_q1 = eval(subs(sol.q1(1),l,2))
sol_II_q1 = eval(subs(sol.q1(2),l,2))
sol_I_q2 = eval(subs(sol.q2(1),l,2))
sol_II_q2 = eval(subs(sol.q2(2),l,2))
sol_I_q3 = eval(subs(sol.q3(1),l,2))
sol_II_q3 = eval(subs(sol.q3(2),l,2))

J_subs = eval(subs(J,[q1,q2,q3,l],[sol_II_q1,sol_II_q2,sol_II_q3,2]))

