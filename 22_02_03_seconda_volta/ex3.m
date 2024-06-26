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
J_dot = simplify(J_dot, steps = 10);

J_dot = collect(J_dot, [cos(q1), cos(q1+q2), cos(q1+q2+q3), sin(q1), sin(q1+q2), sin(q1+q2+q3)])

det_J = simplify(det(J),steps=100)

q_val = [pi/4; pi/3; -pi/2]
q_dot_val = [-0.8; 1; 0.2]
p_dot_dot = [1;1;0]
J_subs = eval(subs(J,[q1,q2,q3],[pi/4,pi/3,-pi/2]))

p_dot = J_subs*q_dot_val
J_dot_subs = subs(J_dot,[q1,q2,q3,q1_dot,q2_dot,q3_dot],[pi/4,pi/3,-pi/2,-0.8,1,0.2]);
q_dot_dot_val = double(inv(J_subs)*(p_dot_dot-J_dot_subs*q_dot_val))

p_subs = eval(subs(p,[q1,q2,q3],[pi/4,pi/3,-pi/2]))