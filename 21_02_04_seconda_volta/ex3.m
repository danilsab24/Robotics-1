clear all
clc

% Dati del problema
L1 = 1;  % Lunghezza del primo link
L2 = 1;  % Lunghezza del secondo link
theta1 = pi/4;  % Angolo del primo giunto
theta2 = pi/3;  % Angolo del secondo giunto
delta1 = 0.01;  % Piccolo errore angolare del primo giunto
delta2 = 0.01;  % Piccolo errore angolare del secondo giunto

% Calcolo dell'errore di posizione
[dx, dy] = compute_position_error(L1, L2, theta1, theta2, delta1, delta2);

% Visualizzazione dei risultati
disp(['Errore in x: ', num2str(dx)]);
disp(['Errore in y: ', num2str(dy)]);

function [dx, dy] = compute_position_error(L1, L2, theta1, theta2, delta1, delta2)
    % Calcolo della posizione con errori angolari
    x_true = L1 * cos(theta1) + L2 * cos(theta1 + theta2);
    y_true = L1 * sin(theta1) + L2 * sin(theta1 + theta2);

    % Posizione con errori angolari
    x_err = L1 * cos(theta1 + delta1) + L2 * cos(theta1 + delta1 + theta2 + delta2);
    y_err = L1 * sin(theta1 + delta1) + L2 * sin(theta1 + delta1 + theta2 + delta2);

    % Calcolo degli errori
    dx = x_err - x_true;
    dy = y_err - y_true;
end
