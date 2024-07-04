clear all
clc

% Definizione delle variabili simboliche
syms t omega

% Parametri dati
a = 1; % [m]
b = 1.5; % [m]
c = 3; % [m]
V1 = 2; % [m/s]
V2 = 2; % [m/s]
Vc_max = 1.8; % [m/s]
A1 = 2; % [m/s^2]
A2 = 1.5; % [m/s^2]

% Traiettoria desiderata
pd = [c + a * sin(2 * omega * t); c + b * sin(omega * t)];

% Derivate della traiettoria (velocità)
pd_dot = diff(pd, t);

% Derivate seconde della traiettoria (accelerazioni)
pd_ddot = diff(pd_dot, t);

% Calcolo della velocità e accelerazione dei giunti
q_dot = pd_dot;
q_ddot = pd_ddot;

% Valori numerici per la valutazione
omega_val = 1; % Puoi modificare questo valore in base alle necessità
time = linspace(0, 2*pi/omega_val, 1000);

% Valutazione delle velocità e accelerazioni in funzione del tempo
q_dot_vals = double(subs(q_dot, {omega, t}, {omega_val, time}));
q_ddot_vals = double(subs(q_ddot, {omega, t}, {omega_val, time}));

% Grafico delle velocità dei giunti
figure;
subplot(2, 1, 1);
plot(time, q_dot_vals(1,:), 'r', time, q_dot_vals(2,:), 'b');
title('Joint Velocities');
xlabel('Time [s]');
ylabel('Velocity [m/s]');
legend('q1 dot', 'q2 dot');

% Grafico delle accelerazioni dei giunti
subplot(2, 1, 2);
plot(time, q_ddot_vals(1,:), 'r', time, q_ddot_vals(2,:), 'b');
title('Joint Accelerations');
xlabel('Time [s]');
ylabel('Acceleration [m/s^2]');
legend('q1 ddot', 'q2 ddot');

% Calcolo di omega_max per soddisfare i vincoli di velocità e accelerazione
omega_max = min([V1/b, V2/(2*a), Vc_max /sqrt((4*a^2 + b^2)), sqrt(A2/4*a), sqrt(A1/b)]);

% Visualizzazione di omega_max
disp('Il valore massimo di omega è:');
disp(omega_max);

