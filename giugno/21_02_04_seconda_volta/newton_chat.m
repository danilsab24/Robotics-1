
clear all
clc

syms epsilon

% Configurazione iniziale
q0 = [pi/4; epsilon];

% Posizioni desiderate
pd_I = [-1; 1];
pd_II = [1; 1];

% Parametro di aggiornamento per il metodo del Gradiente
alpha = 0.01;

% Prima iterazione per pd_I
q1_newton_I = simplify(newton_method(q0, pd_I, alpha),steps=100)
q1_gradient_I = simplify(gradient_method(q0, pd_I, alpha),steps=100)

% Prima iterazione per pd_II
q1_newton_II = simplify(newton_method(q0, pd_II, alpha),steps=100)
q1_gradient_II = simplify(gradient_method(q0, pd_II, alpha),steps=100)
% Funzione di cinematica diretta
function p = f(q)
    p = [q(2) * cos(q(1)); q(2) * sin(q(1))];
end

% Jacobiano della funzione di cinematica diretta
function J = Jf(q)
    J = [-q(2) * sin(q(1)), cos(q(1));
         q(2) * cos(q(1)), sin(q(1))];
end

% Metodo di Newton
function q_new = newton_method(q, pd, alpha)
    p = f(q);
    J = Jf(q);
    q_new = q + inv(J) * (pd - p);
end

% Metodo del Gradiente
function q_new = gradient_method(q, pd, alpha)
    p = f(q);
    J = Jf(q);
    q_new = q + alpha * J' * (pd - p);
end
