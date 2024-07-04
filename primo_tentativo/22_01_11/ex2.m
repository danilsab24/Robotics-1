clear all
clc

risolvi_sistema()

function soluzione = risolvi_sistema()
    % Definizione delle equazioni
    funzioni = @(x) [cos(x(1))+(sqrt(2)*cos(x(1)+x(3)))-(x(2)*sin(x(1)))-2;
                     sin(x(1))+(sqrt(2)*sin(x(1)+x(3)))+(x(2)*cos(x(1)))-1;
                      x(1)+x(3)+pi/6]

    % Guess iniziale per le variabili q1, q2, q3
    x0 = [0; 0; 0];

    % Risoluzione del sistema di equazioni
    options = optimoptions('fsolve','Display','iter');
    sol = fsolve(funzioni, x0, options);

    % Stampa dei valori dei risultati in un vettore colonna
    soluzione = sol';
end