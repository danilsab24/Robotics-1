clear all
clc

% Definizione delle lunghezze dei link
l1 = 0.5;
l2 = 0.4;

% Posizione desiderata
pd = [0.4; -0.3];

% Parametri di iterazione
kmax = 3;
epsilon = 1e-4;

% Cinematica diretta simbolica
syms q1 q2 real;
p = [l1 * cos(q1) + l2 * cos(q1 + q2);
     l1 * sin(q1) + l2 * sin(q1 + q2)];

% Soluzione analitica
c2 = (pd(1)^2 + pd(2)^2 - (l1^2 + l2^2)) / (2 * l1 * l2);
s2 = sqrt(1 - c2^2); % Soluzione positiva
q2_sol = atan2(s2, c2); 
q1_sol = atan2(pd(2), pd(1)) - atan2(l2 * s2, l1 + l2 * c2);
qa = [q1_sol; q2_sol];

s2 = -sqrt(1 - c2^2); % Soluzione negativa
q2_sol = atan2(s2, c2); 
q1_sol = atan2(pd(2), pd(1)) - atan2(l2 * s2, l1 + l2 * c2);
qb = [q1_sol; q2_sol];

% Jacobiana simbolica e sua inversa
J = jacobian(p, [q1 q2]);
J_inv = inv(J);

% Funzione per la cinematica diretta numerica
f = @(q) [l1 * cos(q(1)) + l2 * cos(q(1) + q(2));
          l1 * sin(q(1)) + l2 * sin(q(1) + q(2))];

% Iterazioni del metodo di Newton per qa
qk = qa + [0.2; 0]; % Configurazione iniziale q0_a
error_a = zeros(1, kmax); % Array per memorizzare l'errore
for i = 1:kmax
    J_num = double(subs(J, [q1 q2], [qk(1) qk(2)]));
    p_qk = double(subs(p, [q1 q2], [qk(1) qk(2)]));
    delta_q = J_num \ (pd - p_qk);
    qk = qk + delta_q;
    error_a(i) = norm(pd - p_qk);
    if error_a(i) < epsilon
        error_a = error_a(1:i);
        break;
    end
    if i == kmax
        disp('NO convergence for q0_a');
    end
end
qa_final = qk;
disp('Soluzione finale per q_a:');
disp(qa_final);

% Iterazioni del metodo di Newton per qb
qk = qb + [0; 0.2]; % Configurazione iniziale q0_b
error_b = zeros(1, kmax); % Array per memorizzare l'errore
for i = 1:kmax
    J_num = double(subs(J, [q1 q2], [qk(1) qk(2)]));
    p_qk = double(subs(p, [q1 q2], [qk(1) qk(2)]));
    delta_q = J_num \ (pd - p_qk);
    qk = qk + delta_q;
    error_b(i) = norm(pd - p_qk);
    if error_b(i) < epsilon
        error_b = error_b(1:i);
        break;
    end
    if i == kmax
        disp('NO convergence for q0_b');
    end
end
qb_final = qk;
disp('Soluzione finale per q_b:');
disp(qb_final);

% Plot dell'errore ad ogni iterazione
figure;
plot(1:length(error_a), error_a, '-o', 'DisplayName', 'q0_a');
hold on;
plot(1:length(error_b), error_b, '-x', 'DisplayName', 'q0_b');
xlabel('Iterazione');
ylabel('Errore');
title('Errore ad ogni iterazione per il metodo di Newton');
legend show;
grid on;
