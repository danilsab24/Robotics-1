clear all
clc

syms q1 q2 q3 L Fx Fy M

p = [q1+L*cos(q2)+L*cos(q2+q3);
      L*sin(q2)+L*sin(q2+q3);
             q2+q3]

J = jacobian(p,[q1,q2,q3])

det_J = simplify(det(J), steps=100)

% I consider singularities q2=pi/2

J_subs = subs(J,q2,pi/2)
NULL_SPACE_J = null(J_subs)
NULL_SPACE_J_t = simplify(null(J_subs.'),steps=100)
RANGE_SPACE_J = simplify(colspace(J_subs),steps=100)
r_dot_I = [1;0;0];
q_dot_I = simplify(pinv(J_subs)*r_dot_I)

% per trovare q_dot_II che non appartiene al range space
rank_RANGE_SPACE = rank(RANGE_SPACE_J)
prova_I = [0;0;1];
RANGE_SPACE_J_II = [RANGE_SPACE_J prova_I]
rank_RANGE_SPACE_J_II = rank(RANGE_SPACE_J_II)

% punto c
P_I = subs(p,L,0.5)
eq1 = P_I(1)==0.3;
eq2 = P_I(2)==0.7;
eq3 = P_I(3)==pi/3;
sol = solve([eq1,eq2,eq3],[q1,q2,q3])
disp("solutions q1:")
disp(eval(sol.q1))
disp("solutions q2:")
disp(eval(sol.q2))
disp("solutions q3:")
disp(eval(sol.q3))



