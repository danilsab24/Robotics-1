clear all
clc

% Parametri
V1 = 4; % [rad/s]
V2 = 8; % [rad/s]
A1 = 20; % [rad/s^2]
A2 = 40; % [rad/s^2]

% Tempo minimo fattibile
T = 0.6226; % [s]

% Traiettorie
t = linspace(0, T, 100);

q1 = pi/4 + pi/4 * (3 * (t / T).^2 - 2 * (t / T).^3);
q2 = -pi/2 * (1 - cos(pi * t / T));

dq1 = pi/4 * (6 * (t / T.^2) - 6 * (t.^2 / T.^3));
dq2 = -(pi^2 / 2 / T) * sin(pi * t / T);

ddq1 = pi/4 * (6 / T^2 - 12 * t / T^3);
ddq2 = (pi^3 / 2 / T^2) * cos(pi * t / T);

% Tracciare le traiettorie
figure;
subplot(3,2,1);
plot(t, q1, 'LineWidth', 2);
title('Traiettoria di q1');
xlabel('Tempo [s]');
ylabel('Angolo [rad]');
grid on;

subplot(3,2,2);
plot(t, q2, 'LineWidth', 2);
title('Traiettoria di q2');
xlabel('Tempo [s]');
ylabel('Angolo [rad]');
grid on;

subplot(3,2,3);
plot(t, dq1, 'LineWidth', 2);
title('Velocità di q1');
xlabel('Tempo [s]');
ylabel('Velocità [rad/s]');
grid on;

subplot(3,2,4);
plot(t, dq2, 'LineWidth', 2);
title('Velocità di q2');
xlabel('Tempo [s]');
ylabel('Velocità [rad/s]');
grid on;

subplot(3,2,5);
plot(t, ddq1, 'LineWidth', 2);
title('Accelerazione di q1');
xlabel('Tempo [s]');
ylabel('Accelerazione [rad/s^2]');
grid on;

subplot(3,2,6);
plot(t, ddq2, 'LineWidth', 2);
title('Accelerazione di q2');
xlabel('Tempo [s]');
ylabel('Accelerazione [rad/s^2]');
grid on;
