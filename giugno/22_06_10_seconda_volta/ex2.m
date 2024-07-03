clear all 
clc

syms q1 q2 q1_dot q2_dot

p = [q2*cos(q1);
     q2*sin(q1)]

J = simplify(jacobian(p,[q1,q2]),steps=100)

q = [q1; q2]

q_dot = [q1_dot;q2_dot]

%% derivative of jacobian
dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
J_dot = simplify(J_dot, steps = 10)

J_dot = collect(J_dot, [cos(q1),sin(q1)]);

q_dot_dot_val = simplify(inv(J)*(-J_dot*q_dot), steps=100)