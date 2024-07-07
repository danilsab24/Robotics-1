clear all
clc

% Parametri del problema
qi1 = 0; % Posizione iniziale giunto 1 (rad)
qf1 = -pi/2; % Posizione finale giunto 1 (rad)
qi2 = -pi/2; % Posizione iniziale giunto 2 (rad)
qf2 = pi/2; % Posizione finale giunto 2 (rad)
T = 2; % Tempo totale (s) (esempio)

% Calcolo dei coefficienti della traiettoria quintica per giunto 1
A = [1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0;
     0, 0, 2, 0, 0, 0;
     1, T, T^2, T^3, T^4, T^5;
     0, 1, 2*T, 3*T^2, 4*T^3, 5*T^4;
     0, 0, 2, 6*T, 12*T^2, 20*T^3];
 
b1 = [qi1; 0; 0; qf1; 0; 0];
b2 = [qi2; 0; 0; qf2; 0; 0];

coeffs1 = A\b1;
coeffs2 = A\b2;

% Creazione dei vettori di tempo
t = linspace(0, T, 1000);

% Calcolo dei profili di posizione, velocità e accelerazione per giunto 1
q1 = polyval(flip(coeffs1'), t);
v1 = polyval(polyder(flip(coeffs1')), t);
a1 = polyval(polyder(polyder(flip(coeffs1'))), t);

% Calcolo dei profili di posizione, velocità e accelerazione per giunto 2
q2 = polyval(flip(coeffs2'), t);
v2 = polyval(polyder(flip(coeffs2')), t);
a2 = polyval(polyder(polyder(flip(coeffs2'))), t);

% Tracciamento dei profili
figure;

subplot(3, 1, 1);
plot(t, q1, 'b', t, q2, 'r');
xlabel('Tempo (s)');
ylabel('Posizione (rad)');
title('Posizione - Traiettoria Quintica Rest-to-Rest');
legend('Giunto 1', 'Giunto 2');

subplot(3, 1, 2);
plot(t, v1, 'b', t, v2, 'r');
xlabel('Tempo (s)');
ylabel('Velocità (rad/s)');
title('Velocità - Traiettoria Quintica Rest-to-Rest');
legend('Giunto 1', 'Giunto 2');

subplot(3, 1, 3);
plot(t, a1, 'b', t, a2, 'r');
xlabel('Tempo (s)');
ylabel('Accelerazione (rad/s^2)');
title('Accelerazione - Traiettoria Quintica Rest-to-Rest');
legend('Giunto 1', 'Giunto 2');

disp('Traiettoria calcolata con successo');

