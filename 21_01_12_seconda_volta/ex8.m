clear all
clc
%scritto da chatgpt 4o
% Parametri
l1 = 0.5;
l2 = 0.4;
v = 0.3;
T = 2;
beta = -20 * pi / 180;
P0 = [-0.8, 1.1];

% Posizione finale dell'obiettivo
Pf = P0 + v * T * [cos(beta), sin(beta)];

% Cinematica inversa per trovare q1f e q2f
x = Pf(1);
y = Pf(2);

% Calcolo del valore per q2
cos_q2 = (x^2 + y^2 - l1^2 - l2^2) / (2 * l1 * l2);

% Assicurarsi che il valore sia compreso tra -1 e 1
if cos_q2 < -1
    cos_q2 = -1;
elseif cos_q2 > 1
    cos_q2 = 1;
end

q2f = acos(cos_q2);
q1f = atan2(y, x) - atan2(l2 * sin(q2f), l1 + l2 * cos(q2f));

% Configurazione iniziale
qs = [pi, 0];

% Traiettorie di polinomi di terzo ordine
t = linspace(0, T, 100);
q1 = pi + (q1f - pi) * (3 * (t / T).^2 - 2 * (t / T).^3);
q2 = 0 + q2f * (3 * (t / T).^2 - 2 * (t / T).^3);

% Tracciare le traiettorie
figure;
subplot(2,1,1);
plot(t, q1, 'LineWidth', 2);
title('Traiettoria di q1');
xlabel('Tempo [s]');
ylabel('Angolo [rad]');
grid on;

subplot(2,1,2);
plot(t, q2, 'LineWidth', 2);
title('Traiettoria di q2');
xlabel('Tempo [s]');
ylabel('Angolo [rad]');
grid on;

% Cinematica diretta per tracciare la traiettoria dell'end-effector
px = l1 * cos(q1) + l2 * cos(q1 + q2);
py = l1 * sin(q1) + l2 * sin(q1 + q2);

figure;
plot(px, py, 'LineWidth', 2);
title('Traiettoria dell''end-effector');
xlabel('x [m]');
ylabel('y [m]');
grid on;
axis equal;
