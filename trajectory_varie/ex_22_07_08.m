
% Salva questo codice in un file chiamato "trajectory_planning.m"

clear all
clc;
syms qs qg q_dot_s q_dot_g q_dot_dot_s q_dot_dot_g real;
syms T
syms a b c d e f tau

q_dot_g = 0;
q_dot_dot_s = 0;
q_dot_dot_g = 0;

% Matrice dei coefficienti senza termini noti
A = [0, 0, 0, 0, 0, 1;
     1, 1, 1, 1, 1, 1;
     0, 0, 0, 0, 1, 0;
     5, 4, 3, 2, 1, 0;
     0, 0, 0, 2, 0, 0;
     20, 12, 6, 2, 0, 0];

% Vettore dei termini noti
B = [qs;
     qg;
     q_dot_s*T;
     q_dot_g;
     q_dot_dot_s*T^2;
     q_dot_dot_g*T^2];

x = simplify(A\B, 'steps', 100);

% Calcolo dei coefficienti per ciascuna traiettoria
x_q1 = subs(x, [qs, qg, q_dot_s, T], [-pi/4, 0, 2.8284, 2]);
x_q2 = subs(x, [qs, qg, q_dot_s, T], [pi/4, 0, -8.4853, 2]);
x_q3 = subs(x, [qs, qg, q_dot_s, T], [pi/4, pi/4, 0, 2]);

% Definizione della traiettoria
q_tau = a*tau^5 + b*tau^4 + c*tau^3 + d*tau^2 + e*tau + f;
q_tau_q1 = subs(q_tau, [a, b, c, d, e, f], x_q1.')
q_tau_q2 = eval(subs(q_tau, [a, b, c, d, e, f], x_q2.'))
q_tau_q3 = subs(q_tau, [a, b, c, d, e, f], x_q3.')

% Definizione della velocità
q_tau_dot = (1/T)*(5*a*tau^4 + 4*b*tau^3 + 3*c*tau^2 + 2*d*tau + e);
q_tau_dot_q1 = subs(q_tau_dot, [a, b, c, d, e, f, T], [x_q1.', 2]);
q_tau_dot_q2 = subs(q_tau_dot, [a, b, c, d, e, f, T], [x_q2.', 2]);
q_tau_dot_q3 = subs(q_tau_dot, [a, b, c, d, e, f, T], [x_q3.', 2]);

% Definizione dell'accelerazione
q_tau_dot_dot = (1/T^2)*(20*a*tau^3 + 12*b*tau^2 + 6*c*tau + 2*d);
q_tau_dot_dot_q1 = subs(q_tau_dot_dot, [a, b, c, d, e, f, T], [x_q1.', 2]);
q_tau_dot_dot_q2 = subs(q_tau_dot_dot, [a, b, c, d, e, f, T], [x_q2.', 2]);
q_tau_dot_dot_q3 = subs(q_tau_dot_dot, [a, b, c, d, e, f, T], [x_q3.', 2]);

% Genera i valori di tempo (tau)
tau_values = linspace(0, 1, 100);

% Calcola le espressioni q_tau_q1, q_tau_q2, e q_tau_q3
q_tau_q1_values = double(subs(q_tau_q1, tau, tau_values));
q_tau_q2_values = double(subs(q_tau_q2, tau, tau_values));
q_tau_q3_values = double(subs(q_tau_q3, tau, tau_values));

q_tau_dot_q1_values = double(subs(q_tau_dot_q1, tau, tau_values));
q_tau_dot_q2_values = double(subs(q_tau_dot_q2, tau, tau_values));
q_tau_dot_q3_values = double(subs(q_tau_dot_q3, tau, tau_values));

q_tau_dot_dot_q1_values = double(subs(q_tau_dot_dot_q1, tau, tau_values));
q_tau_dot_dot_q2_values = double(subs(q_tau_dot_dot_q2, tau, tau_values));
q_tau_dot_dot_q3_values = double(subs(q_tau_dot_dot_q3, tau, tau_values));

% Crea il grafico delle traiettorie
figure;
plot(tau_values, q_tau_q1_values, 'DisplayName', 'q_{1}(\tau)');
hold on;
plot(tau_values, q_tau_q2_values, 'DisplayName', 'q_{2}(\tau)');
plot(tau_values, q_tau_q3_values, 'DisplayName', 'q_{3}(\tau)');
xlabel('Time (\tau)');
ylabel('q(\tau)');
title('Curves for $$q_{1}(\tau)$$, $$q_{2}(\tau)$$, and $$q_{3}(\tau)$$', 'Interpreter', 'latex');
legend;
grid on;
hold off;

% Crea il grafico delle velocità
figure;
plot(tau_values, q_tau_dot_q1_values, 'DisplayName', 'first joint');
hold on;
plot(tau_values, q_tau_dot_q2_values, 'DisplayName', 'second joint');
plot(tau_values, q_tau_dot_q3_values, 'DisplayName', 'third joint');
xlabel('Time (\tau)');
ylabel('velocity');
title('Curves for $$\dot{q}_{1}(\tau)$$, $$\dot{q}_{2}(\tau)$$, and $$\dot{q}_{3}(\tau)$$', 'Interpreter', 'latex');
legend;
grid on;
hold off;

% Crea il grafico delle accelerazioni
figure;
plot(tau_values, q_tau_dot_dot_q1_values, 'DisplayName', 'first joint');
hold on;
plot(tau_values, q_tau_dot_dot_q2_values, 'DisplayName', 'second joint');
plot(tau_values, q_tau_dot_dot_q3_values, 'DisplayName', 'third joint');
xlabel('Time (\tau)');
ylabel('acceleration');
title('Curves for $$\ddot{q}_{1}(\tau)$$, $$\ddot{q}_{2}(\tau)$$, and $$\ddot{q}_{3}(\tau)$$', 'Interpreter', 'latex');
legend;
grid on;
hold off;
