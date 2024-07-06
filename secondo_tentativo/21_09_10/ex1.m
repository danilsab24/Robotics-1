clear all
clc

syms q1 q2 q3 L Fx Fy Fz

p = [q1+L*cos(q2)+L*cos(q2+q3);
         L*sin(q2)+L*sin(q2+q3);
               q2+q3]

J = jacobian(p,[q1,q2,q3])

det_J = simplify(det(J),steps=100)

J_subs = simplify(subs(J,q2,pi/2),steps=100)

NULL_J_subs = null(J_subs)

RANGE_J_subs = colspace(J_subs)

r_dot_1 = [1;0;0]

q_dot_1 = pinv(J_subs)*r_dot_1

r_dot_2 = [1;0;1]

q_dot_2 = pinv(J_subs)*r_dot_2

F = [Fx;Fy;Fz];

eq = J_subs.'*F

eq1 = eq(1) == 0;
eq2 = eq(2) == 0;
eq3 = eq(3) == 0;

sol = solve([eq1,eq2,eq3],[Fx,Fy,Fz])

e1 = q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3) == 0.3;
e2 = (0.5)*sin(q2)+(0.5)*sin(q2+q3) == 0.7;
e3 = q2+q3 == pi/3;

sol_II = solve([e1,e2,e3],[q1,q2,q3])
disp("soluzioni")
disp("q1")
disp(eval(sol_II.q1(1)))
disp(eval(sol_II.q1(2)))
disp("q2")
disp(eval(sol_II.q2(1)))
disp(eval(sol_II.q2(2)))
disp("q3")
disp(eval(sol_II.q3(1)))
disp(eval(sol_II.q3(2)))
