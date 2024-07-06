clear all
clc

syms q1 q2 q3 real
syms L M N real

% Espressione della cinematica diretta
p = [L*cos(q1) + N*cos(q1 + q2)*cos(q3);
     L*sin(q1) + N*sin(q1 + q2)*cos(q3);
     M + N*sin(q3)];

% Posizione desiderata dell'end-effector
p_d = [0.3; -0.3; 0.7];

% Dati numerici
L_val = 0.5;
M_val = 0.5;
N_val = 0.5;

% Calcolo delle possibili soluzioni per q3
s_3 = (p_d(3) - M_val) / N_val;
c_3_pos = sqrt(1 - s_3^2);
c_3_neg = -sqrt(1 - s_3^2);

q3_I = atan2(s_3, c_3_pos);
q3_II = atan2(s_3, c_3_neg);

% Soluzioni possibili per q2
l1_pos = N_val * c_3_pos;
l1_neg = N_val * c_3_neg;
l2 = L_val;

c_2_I = (p_d(1)^2 + p_d(2)^2 - (l1_pos^2 + l2^2)) / (2 * l1_pos * l2);
c_2_II = (p_d(1)^2 + p_d(2)^2 - (l1_neg^2 + l2^2)) / (2 * l1_neg * l2);

s_2_pos_I = sqrt(1 - c_2_I^2);
s_2_pos_II = sqrt(1 - c_2_II^2);

s_2_neg_I = -sqrt(1 - c_2_I^2);
s_2_neg_II = -sqrt(1 - c_2_II^2);

q2_I_pos = atan2(s_2_pos_I, c_2_I);
q2_I_neg = atan2(s_2_neg_I, c_2_I);
q2_II_pos = atan2(s_2_pos_II, c_2_II);
q2_II_neg = atan2(s_2_neg_II, c_2_II);

% Determinante del sistema per calcolare q1
det_A_pos = L_val^2 + (N_val^2) * (c_3_pos)^2 + 2 * N_val * L_val * c_2_I * c_3_pos;
det_A_neg = L_val^2 + (N_val^2) * (c_3_neg)^2 + 2 * N_val * L_val * c_2_II * c_3_neg;

% Calcolo delle soluzioni per q1
s1_I_pos = (p_d(2) * (l1_pos + l2 * c_2_I) - p_d(1) * (l2 * s_2_pos_I)) / det_A_pos;
c1_I_pos = (p_d(1) * (l1_pos + l2 * c_2_I) + p_d(2) * (l2 * s_2_pos_I)) / det_A_pos;
q1_I_pos = atan2(s1_I_pos, c1_I_pos);

s1_I_neg = (p_d(2) * (l1_pos + l2 * c_2_I) - p_d(1) * (l2 * s_2_neg_I)) / det_A_pos;
c1_I_neg = (p_d(1) * (l1_pos + l2 * c_2_I) + p_d(2) * (l2 * s_2_neg_I)) / det_A_pos;
q1_I_neg = atan2(s1_I_neg, c1_I_neg);

s1_II_pos = (p_d(2) * (l1_neg + l2 * c_2_II) - p_d(1) * (l2 * s_2_pos_II)) / det_A_neg;
c1_II_pos = (p_d(1) * (l1_neg + l2 * c_2_II) + p_d(2) * (l2 * s_2_pos_II)) / det_A_neg;
q1_II_pos = atan2(s1_II_pos, c1_II_pos);

s1_II_neg = (p_d(2) * (l1_neg + l2 * c_2_II) - p_d(1) * (l2 * s_2_neg_II)) / det_A_neg;
c1_II_neg = (p_d(1) * (l1_neg + l2 * c_2_II) + p_d(2) * (l2 * s_2_neg_II)) / det_A_neg;
q1_II_neg = atan2(s1_II_neg, c1_II_neg);

% Soluzioni inverse della cinematica
sol_q1 = [q1_I_pos, q1_I_neg, q1_II_pos, q1_II_neg];
sol_q2 = [q2_I_pos, q2_I_neg, q2_II_pos, q2_II_neg];
sol_q3 = [q3_I, q3_II];

disp('Soluzioni inverse della cinematica:');
disp('q1:');
disp(sol_q1);
disp('q2:');
disp(sol_q2);
disp('q3:');
disp(sol_q3);
