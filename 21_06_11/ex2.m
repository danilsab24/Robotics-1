clc
clear all

% Definizione delle variabili simboliche
syms q1 q2 q3 px py l alfa

% Calcolo della Jacobiana simbolica
P = [q2*cos(q1) + l*cos(q1+q3);
     q2*sin(q1) + l*sin(q1+q3);
     q1+q3]

J_P = simplify(jacobian(P, [q1,q2,q3]))

% Definizione dei valori numerici
px = 2
py = 0.4
l = 0.6
alfa = -pi/2

q2_pos_d = + sqrt((px - l * cos(alfa))^2 + (py - l * sin(alfa))^2)
q2_neg_d = - sqrt((px - l * cos(alfa))^2 + (py - l * sin(alfa))^2)

q1_d = atan2(py - l * sin(alfa), px - l * cos(alfa))

q3_d = alfa - q1_d

% Sostituzione dei valori numerici nella Jacobiana
J_P_sub = subs(J_P, [q1, q2, q3, l], [q1_d, q2_pos_d, q3_d, 0.6])

% Calcolo della velocità 
r_dot = [0; -2.5; 0]
q_dot = double(inv(J_P_sub)*r_dot) % Converte i risultati in numerici

% Calcolo della forza e torzione
F = [-15; 0; -6]
tau = eval(transpose(J_P_sub)*F) % uso eval invece di double perchè MatLab è stupido :(
