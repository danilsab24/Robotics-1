clear all
clc

% Parametri del problema
qi = pi/2; % Posizione iniziale (rad)
qf = 0; % Posizione finale (rad)
vi = 1.5; % Velocità iniziale (rad/s)
vf = 0; % Velocità finale (rad/s)
V = 2; % Velocità massima (rad/s)
A = 4; % Accelerazione massima (rad/s^2)

% Parte 1: Movimento rest-to-rest

% Tempo di accelerazione/decelerazione per il movimento rest-to-rest
t_acc = V / A;
% Distanza coperta durante l'accelerazione/decelerazione
d_acc = 0.5 * A * t_acc^2;
% Distanza rimanente
d_remain = abs(qi - qf) - 2 * d_acc;

if d_remain > 0
    % Tempo di crociera
    t_cruise = d_remain / V;
else
    % Nessuna fase di crociera
    t_cruise = 0;
    t_acc = sqrt(abs(qi - qf) / A);
end

% Tempo totale per il movimento rest-to-rest
T0 = 2 * t_acc + t_cruise;

% Parte 2: Movimento da vi a vf

% Tempo di accelerazione/decelerazione per portare vi a 0
t1_acc = (vi - vf) / A;

% Tempo totale per il movimento da vi a vf
T1 = t1_acc;

% Tracciamento dei profili di posizione, velocità e accelerazione

% Creazione dei vettori di tempo
t0 = linspace(0, T0, 1000);
t1 = linspace(0, T1, 1000);

% Inizializzazione dei vettori
q0 = zeros(size(t0));
v0 = zeros(size(t0));
a0 = zeros(size(t0));
q1 = zeros(size(t1));
v1 = zeros(size(t1));
a1 = zeros(size(t1));

% Calcolo dei profili per il movimento rest-to-rest
for i = 1:length(t0)
    if t0(i) <= t_acc
        a0(i) = A;
        v0(i) = a0(i) * t0(i);
        q0(i) = qi + 0.5 * a0(i) * t0(i)^2;
    elseif t0(i) <= t_acc + t_cruise
        a0(i) = 0;
        v0(i) = V;
        q0(i) = qi + V * (t0(i) - t_acc) + 0.5 * A * t_acc^2;
    else
        a0(i) = -A;
        v0(i) = V - A * (t0(i) - t_acc - t_cruise);
        q0(i) = qi + V * t_cruise + V * (t0(i) - t_acc - t_cruise) - 0.5 * A * (t0(i) - t_acc - t_cruise)^2;
    end
end

% Calcolo dei profili per il movimento da vi a vf
for i = 1:length(t1)
    a1(i) = -A;
    v1(i) = vi + a1(i) * t1(i);
    q1(i) = qi + vi * t1(i) + 0.5 * a1(i) * t1(i)^2;
end

% Tracciamento dei profili
figure;

subplot(3, 2, 1);
plot(t0, q0);
xlabel('Tempo (s)');
ylabel('Posizione (rad)');
title('Posizione - Movimento Rest-to-Rest');

subplot(3, 2, 3);
plot(t0, v0);
xlabel('Tempo (s)');
ylabel('Velocità (rad/s)');
title('Velocità - Movimento Rest-to-Rest');

subplot(3, 2, 5);
plot(t0, a0);
xlabel('Tempo (s)');
ylabel('Accelerazione (rad/s^2)');
title('Accelerazione - Movimento Rest-to-Rest');

subplot(3, 2, 2);
plot(t1, q1);
xlabel('Tempo (s)');
ylabel('Posizione (rad)');
title('Posizione - Movimento da vi a vf');

subplot(3, 2, 4);
plot(t1, v1);
xlabel('Tempo (s)');
ylabel('Velocità (rad/s)');
title('Velocità - Movimento da vi a vf');

subplot(3, 2, 6);
plot(t1, a1);
xlabel('Tempo (s)');
ylabel('Accelerazione (rad/s^2)');
title('Accelerazione - Movimento da vi a vf');

disp(['Tempo minimo T0 per il movimento rest-to-rest: ', num2str(T0), ' s']);
disp(['Tempo minimo T1 per il movimento da vi a vf: ', num2str(T1), ' s']);
