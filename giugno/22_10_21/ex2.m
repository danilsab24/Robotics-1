clear all
clc

% Dati iniziali
p_x_in = 2 + 1/sqrt(2);
p_y_in = 1/sqrt(2);
p_x_fin = 3/sqrt(2);
p_y_fin = -1/sqrt(2);

l1 = 2; 
l2 = 1; 

% Soluzione per la posizione iniziale
c2_in = (p_x_in^2 + p_y_in^2 - (l1^2 + l2^2)) / (2*l1*l2);
s2_pos_in = sqrt(1 - c2_in^2);
s2_neg_in = -sqrt(1 - c2_in^2);

q2_pos_in = atan2(s2_pos_in, c2_in);
q2_neg_in = atan2(s2_neg_in, c2_in);

q1_pos_in = atan2(p_y_in, p_x_in) - atan2(l2 * s2_pos_in, l1 + l2 * c2_in);
q1_neg_in = atan2(p_y_in, p_x_in) - atan2(l2 * s2_neg_in, l1 + l2 * c2_in);

q_first_in = [q1_pos_in; q2_pos_in];
q_second_in = [q1_neg_in; q2_neg_in];

disp("First solution with P_in:");
disp(q_first_in);
disp("Second solution with P_in:");
disp(q_second_in);

% Soluzione per la posizione finale
c2_fin = (p_x_fin^2 + p_y_fin^2 - (l1^2 + l2^2)) / (2*l1*l2);
s2_pos_fin = sqrt(1 - c2_fin^2);
s2_neg_fin = -sqrt(1 - c2_fin^2);

q2_pos_fin = atan2(s2_pos_fin, c2_fin);
q2_neg_fin = atan2(s2_neg_fin, c2_fin);

q1_pos_fin = atan2(p_y_fin, p_x_fin) - atan2(l2 * s2_pos_fin, l1 + l2 * c2_fin);
q1_neg_fin = atan2(p_y_fin, p_x_fin) - atan2(l2 * s2_neg_fin, l1 + l2 * c2_fin);

q_first_fin = [q1_pos_fin; q2_pos_fin];
q_second_fin = [q1_neg_fin; q2_neg_fin];

disp("First solution with P_fin:");
disp(q_first_fin);
disp("Second solution with P_fin:");
disp(q_second_fin);

% Dati per il moto bang-bang
Vmax1 = 2; % [rad/s]
Vmax2 = 1.5; % [rad/s]

% Calcolo delle accelerazioni e tempi minimi
delta_q1 = q_first_fin(1) - q_first_in(1);
delta_q2 = q_first_fin(2) - q_first_in(2);

%il meno perchè "symmetric bang-bang acceleration profile" dovuti dai constraint dell'esercizio 
Amax1 = -Vmax1^2 / abs(delta_q1)
Amax2 = Vmax2^2 / abs(delta_q2)

T1 = sqrt(4 * abs(delta_q1) / Amax1)
T2 = sqrt(4 * abs(delta_q2) / Amax2)

T = max(T1, T2);

% Accelerazioni ridimensionate per il tempo coordinato
%il meno perchè "symmetric bang-bang acceleration profile" dovuti dai constraint dell'esercizio 
A1 = -4 * abs(delta_q1) / T^2
A2 = 4 * abs(delta_q2) / T^2

t = linspace(0, T, 100);
a1 = A1 * (t < T/2) - A1 * (t >= T/2);
a2 = A2 * (t < T/2) - A2 * (t >= T/2);

% Grafici
figure;
subplot(2,1,1);
plot(t, a1);
title('Profilo di accelerazione per q1');
xlabel('Tempo [s]');
ylabel('Accelerazione [rad/s^2]');
grid on;

subplot(2,1,2);
plot(t, a2);
title('Profilo di accelerazione per q2');
xlabel('Tempo [s]');
ylabel('Accelerazione [rad/s^2]');
grid on;

