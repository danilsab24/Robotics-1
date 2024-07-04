clear all
clc

syms q1 q2 q3 L

p = [q1+L*cos(q2)+L*cos(q2+q3);
      L*sin(q2)+L*sin(q2+q3);
             q2+q3]
eq1 = p(1);
eq2 = p(2);
eq3 = p(3);

eq1_q_in = eq1==2*L;
eq2_q_in = eq2==0;
eq3_q_in = eq3==pi/4;

sol_q_in = solve([eq1_q_in,eq2_q_in,eq3_q_in],[q1,q2,q3]);
disp("solutions q1_in:")
disp(eval(sol_q_in.q1))
disp("solutions q2_in:")
disp(eval(sol_q_in.q2))
disp("solutions q3_in:")
disp(eval(sol_q_in.q3))

eq1_q_fin = eq1==2*L;
eq2_q_fin = eq2==0;
eq3_q_fin = eq3==-pi/4;

sol_q_fin = solve([eq1_q_fin,eq2_q_fin,eq3_q_fin],[q1,q2,q3]);
disp("solutions q1_fin:")
disp(eval(sol_q_fin.q1))
disp("solutions q2_fin:")
disp(eval(sol_q_fin.q2))
disp("solutions q3_fin:")
disp(eval(sol_q_fin.q3))

delta_q = [sol_q_fin.q1(1) - sol_q_in.q1(1);
           sol_q_fin.q2(1) - sol_q_in.q2(1);
           sol_q_fin.q3(1) - sol_q_in.q3(1)]

% Parametri del robot
L = 0.5;
T = 10; % Durata del movimento
t = linspace(0, T, 100); % Vettore temporale

% Condizioni iniziali e finali
ri = [2*L, 0, pi/4];
rf = [2*L, 0, -pi/4];

% Traiettoria desiderata dell'angolo alpha
alpha_i = pi/4;
alpha_f = -pi/4;

% Coefficienti del polinomio cubico
a0 = alpha_i;
a1 = 0;
a2 = (3/(T^2)) * (alpha_f - alpha_i);
a3 = -(2/(T^3)) * (alpha_f - alpha_i);

% Calcolo della traiettoria alpha_d(t)
alpha_d = a0 + a1 * t + a2 * t.^2 + a3 * t.^3;

% Posizione costante del punto P
px_d = 2*L;
py_d = 0;

% Preallocazione dei vettori delle traiettorie dei giunti
q1d = 2*L * ones(1, length(t)); % q1 rimane costante
q2d = zeros(1, length(t));
q3d = zeros(1, length(t));

for i = 1:length(t)
    % Cinematica inversa per trovare q2 e q3
    alpha = alpha_d(i);
    
    % Risolvere le equazioni per q2 e q3
    q2 = acos(px_d / (2 * L));
    q3 = alpha - q2;
    
    q2d(i) = q2;
    q3d(i) = q3;
end

% Plot delle traiettorie dei giunti
figure;
subplot(3, 1, 1);
plot(t, q1d);
xlabel('Tempo [s]');
ylabel('q1 [m]');
title('Trajectory q1');

subplot(3, 1, 2);
plot(t, q2d);
xlabel('Tempo [s]');
ylabel('q2 [rad]');
title('Trajectory q2');

subplot(3, 1, 3);
plot(t, q3d);
xlabel('Tempo [s]');
ylabel('q3 [rad]');
title('Trajectory di q3');

sgtitle('Joint trajectory for robot PRR');

