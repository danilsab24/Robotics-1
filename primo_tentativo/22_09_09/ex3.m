clear all
clc 

syms q1 q2 q3 L q_1dot q_2dot q_3dot
r = [q2*cos(q1) + L*cos(q1+q3); q2*sin(q1) + L*sin(q1 + q3); q1 + q3]

J = simplify(jacobian(r, [q1,q2,q3]), steps=100)

det_J = simplify(det(J), steps=100)

q_s = [q1, 0, q3]

J_subs = subs(J, q2, 0)

% punto 2
%R = simplify(colspace(J_subs), steps = 100)

% punto 3
%null_space_J = null(J_subs)

% punto 4
q = [q1; q2; q3]
q_dot = [q_1dot;q_2dot;q_3dot]
dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
J_dot = simplify(J_dot, steps=100);
J_dot_subs = subs(J_dot, [q1,q2,q3,q_1dot,q_2dot,q_3dot],[pi/2,1,0,1,-1,-1])
q_dot_subs = [1;-1;-1]
J_subs = subs(J,[q1,q2,q3,L], [pi/2,1,0,1])
q_dot_dot = -(inv(J_subs)*J_dot_subs*q_dot_subs)


T = (2*pi + 4)/8
