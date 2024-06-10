clear all
clc

syms q1 q2 q3 q1_dot q2_dot q3_dot

p = [cos(q1)+cos(q1+q2)+cos(q1+q2+q3);
     sin(q1)+sin(q1+q2)+sin(q1+q2+q3);
                 q1+q2+q3];

J = simplify(jacobian(p,[q1,q2,q3]),steps=100)

q = [q1; q2; q3]

q_dot = [q1_dot;q2_dot;q3_dot]

%% derivative of jacobian
dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
J_dot = simplify(J_dot, steps = 10)

%non credo sia necessaria 
%J_dot = collect(J_dot, [cos(q1), cos(q1+q2), cos(q1+q2+q3), sin(q1), sin(q1+q2), sin(q1+q2+q3)])
