clear all
clc

% Parametri del robot
q1_min = -2; % Minimo del primo giunto prismatico
q1_max = 6;  % Massimo del primo giunto prismatico
q2_min = -4; % Minimo del secondo giunto prismatico
q2_max = 5;  % Massimo del secondo giunto prismatico
L = 3;       % Lunghezza del terzo link

% Disegna il workspace primario WS1
figure;
hold on;
axis equal;
grid on;
title('Workspace Primario (WS1) e Secondario (WS2) del robot PPR');
xlabel('x');
ylabel('y');

% Coordinate degli angoli del rettangolo
corners_WS1_x = [q1_min, q1_max, q1_max, q1_min];
corners_WS1_y = [q2_min, q2_min, q2_max, q2_max];

% Disegna il rettangolo principale
fill(corners_WS1_x, corners_WS1_y, 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5);

% Disegna gli angoli arrotondati
theta = linspace(0, pi/2, 100);
arc_x = L * cos(theta);
arc_y = L * sin(theta);

fill([q1_min + L + arc_x, q1_min + L], [q2_min + L, q2_min + arc_y + L], 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5);
fill([q1_max - L - arc_x, q1_max - L], [q2_min + L, q2_min + arc_y + L], 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5);
fill([q1_max - L - arc_x, q1_max - L], [q2_max - L, q2_max - L - arc_y], 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5);
fill([q1_min + L + arc_x, q1_min + L], [q2_max - L, q2_max - L - arc_y], 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5);

% Disegna il workspace secondario WS2
corners_WS2_x = [q1_min + L, q1_max - L, q1_max - L, q1_min + L];
corners_WS2_y = [q2_min + L, q2_min + L, q2_max - L, q2_max - L];

fill(corners_WS2_x, corners_WS2_y, 'g', 'FaceAlpha', 0.5, 'EdgeColor', 'r', 'LineWidth', 1.5);

legend('Workspace Primario (WS1)', 'Workspace Secondario (WS2)', 'Location', 'Best');
hold off;
