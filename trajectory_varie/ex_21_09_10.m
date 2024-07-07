clear all
clc

syms q1 q2 q3 L

p = [q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3);
      (0.5)*sin(q2)+(0.5)*sin(q2+q3);
             q2+q3]
J = simplify(jacobian(p,[q1,q2,q3]),steps=100)

eq1 = q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3) == 1;
eq2 = (0.5)*sin(q2)+(0.5)*sin(q2+q3) == 0;
eq3 = q2+q3 == pi/4;

sol = solve([eq1,eq2,eq3],[q1,q2,q3])
disp("soluzioni di q_in:")
disp("q1_I: "+eval(sol.q1(1)))
disp("q2_I: "+eval(sol.q2(1)))
disp("q3_I: "+eval(sol.q3(1)))
disp(" ")
disp("q1_II: "+eval(sol.q1(2)))
disp("q2_II: "+eval(sol.q2(2)))
disp("q3_II: "+eval(sol.q3(2)))

eq1_II = q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3) == 1;
eq2_II = (0.5)*sin(q2)+(0.5)*sin(q2+q3) == 0;
eq3_II = q2+q3 == -pi/4;

sol_II = solve([eq1_II,eq2_II,eq3_II],[q1,q2,q3])
disp("soluzioni di q_fin:")
disp("q1_I: "+eval(sol_II.q1(1)))
disp("q2_I: "+eval(sol_II.q2(1)))
disp("q3_I: "+eval(sol_II.q3(1)))
disp(" ")
disp("q1_II: "+eval(sol_II.q1(2)))
disp("q2_II: "+eval(sol_II.q2(2)))
disp("q3_II: "+eval(sol_II.q3(2)))

% Definizione dei parametri
L = 0.5; % Lunghezza del link
T = 10; % Tempo totale del movimento
t = linspace(0, T, 100); % Vettore temporale

% Valori iniziali e finali
q1_i = 2*L; q2_i = 0; q3_i = pi/4;
q1_f = 2*L; q2_f = 0; q3_f = -pi/4;

% Traiettoria cubica per q3 (q1 e q2 rimangono costanti)
a0 = q3_i;
a1 = 0;
a2 = (3/(T^2)) * (q3_f - q3_i);
a3 = -(2/(T^3)) * (q3_f - q3_i);

q1 = q1_i * ones(size(t));
q2 = q2_i * ones(size(t));
q3 = a0 + a1*t + a2*t.^2 + a3*t.^3;

% Plottaggio delle traiettorie
figure;
plot(t, q1, 'r', 'DisplayName', 'q1');
hold on;
plot(t, q2, 'g', 'DisplayName', 'q2');
plot(t, q3, 'b', 'DisplayName', 'q3');
hold off;
xlabel('Tempo [s]');
ylabel('Angoli delle giunture');
title('Traiettoria delle giunture del robot PRR');
legend('show');
grid on;
