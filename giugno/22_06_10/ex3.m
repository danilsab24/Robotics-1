clc
clear all

syms q1 q2 p_x_dot_dot p_y_dot_dot real
syms q1_dot q2_dot q1_dot_dot q2_dot_dot real

q = [q1; q2];
q_dot = [q1_dot; q2_dot];
q_dot_dot = [q1_dot_dot; q2_dot_dot];

px = q2*cos(q1);
py = q2*sin(q1);
J = jacobian([px, py], [q1, q2])
tau_1 = 10
tau_2 = 5

tau1 = [tau_1; tau_2]
tau2 = [tau_1; -tau_2]
tau3 = [-tau_1; tau_2]
tau4 = [-tau_1; -tau_2]

J_subs = eval(subs(J, [q1,q2], [pi/3, 1.5]))

F_max_1 = inv(J_subs.')*tau1
F_max_2 = inv(J_subs.')*tau2
F_max_3 = inv(J_subs.')*tau3
F_max_4 = inv(J_subs.')*tau4



