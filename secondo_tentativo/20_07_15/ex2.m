clear all
clc

syms q1 q2 a b c omega t q1_dot q2_dot V1 V2 V_max A1 A2

p = [q2; q1];
J = jacobian(p,[q1,q2])

pd_t = [c+a*sin(2*omega*t); c+b*sin(omega*t)];

pd_t_dot = diff(pd_t, t)
pd_t_dot_dot = diff(pd_t_dot, t)

J_inv = inv(J)
% è il q_dot calcolato da me 
q_dot_first = J_inv*pd_t_dot

q = [q1; q2]
q_dot = [q1_dot; q2_dot]

%% derivative of jacobian
dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
J_dot = simplify(J_dot, steps = 10)

%non si sa se è necessario
%J_dot = collect(J_dot, [cos(q1),sin(q1)]);

q_dot_dot_val = simplify(inv(J)*(-J_dot*q_dot), steps=100)

norm_pd_t_dot = simplify(norm(pd_t_dot),steps=100)

vedi = simplify((cos(2*omega*t))^2 + (cos(omega*t))^2,steps=100)

eq1 = eval(subs(V1/b, [V1,b],[2,1.5]))
eq2 = eval(subs(V2/(2*a),[V2,a],[2,1]))
eq3 = eval(subs(sqrt(A1/b),[A1,b],[2,1.5]))
eq4 = eval(subs(sqrt(A2/(4*a)),[A2,a],[1.5,1]))
eq5 = eval(subs(sqrt(V_max/(sqrt((4*a)^2+(b)^2))),[a,b,V_max],[1,1.5,1.8]))



