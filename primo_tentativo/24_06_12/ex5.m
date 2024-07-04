clear all
clc

syms q1 q2 a1 a2 a3 a4 a0

p = [cos(q1)+cos(q1+q2);
     sin(q1)+sin(q1+q2)]

J = jacobian(p,[q1,q2])

eq1 = p(1) == 0.6;
eq2 = p(2) == -0.4;

eq3 = p(1) == 1;
eq4 = p(2) == 1;

p_dot_i = [-2;0];
p_dot_f = [2;2];

sol = solve([eq1,eq2],[q1,q2])
sol2 = solve([eq3,eq4],[q1,q2])
disp(" ")
disp(eval(sol.q1))
disp(eval(sol.q2))
disp(" ")
disp(sol2.q1)
disp(sol2.q2)

J_i = eval(subs(J,[q1,q2],[sol.q1(1),sol.q2(1)]))
J_f = eval(subs(J,[q1,q2],[sol2.q1(1),sol2.q2(1)]))

q_dot_i = inv(J_i)*p_dot_i
q_dot_f = inv(J_i)*p_dot_f

eq1 = a0 == sol.q1(1);
eq2 =  a1+a2+a3 == sol.q2(1);
eq3 =  a1 == q_dot_i;
eq4 = a1+2*a2+3*a3 == q_dot_f;

sol3 = solve([eq1,eq2,eq3,eq4],[a0,a1,a2,a3])

disp(sol3.a0)
dips(sol3.a1)
dips(sol3.a2)
dips(sol3.a3)