clear all
clc

% Definizione degli angoli di Eulero
syms alpha beta gamma t theta1 theta2 tau_1 tau_2 a1 b1 a2 b2 T1 T2 t1 t2 v theta_v real

% Matrice di rotazione attorno all'asse Z
Rz = [cos(alpha) -sin(alpha) 0;
      sin(alpha) cos(alpha) 0;
      0 0 1];

% Matrice di rotazione attorno all'asse Y
Ry = [cos(beta) 0 sin(beta);
      0 1 0;
      -sin(beta) 0 cos(beta)];

% Matrice di rotazione attorno all'asse X
Rx = [1 0 0;
      0 cos(gamma) -sin(gamma);
      0 sin(gamma) cos(gamma)];

% Prodotto delle tre matrici di rotazione (ZYX)
R = Rz * Ry * Rx;

% Visualizzazione della matrice risultante
disp('La matrice di rotazione risultante R è:');
disp(R);

R1 = [0, -sqrt(2)/2, sqrt(2)/2;
      1, 0, 0;
      0, sqrt(2)/2, sqrt(2)/2];

R2 = [sqrt(2)/2, 1/2, -1/2;
      0, -sqrt(2)/2, -sqrt(2)/2;
      -sqrt(2)/2, 1/2, -1/2];

Rvia = [sqrt(6)/4, sqrt(2)/4, -sqrt(2)/2;
        -sqrt(6)/4, -sqrt(2)/4, -sqrt(2)/2;
        -1/2, sqrt(3)/2, 0];

% Calcolo degli angoli di Eulero ZYX per ciascuna matrice di rotazione
beta_Rvia = atan2(-Rvia(3,1),sqrt((Rvia(3,2))^2+(Rvia(3,3))^2));
gamma_Rvia = atan2(Rvia(3,2)/cos(beta_Rvia), Rvia(3,3)/cos(beta_Rvia));
alpha_Rvia = atan2(Rvia(2,1)/cos(beta_Rvia), Rvia(1,1)/cos(beta_Rvia));

beta_R1 = atan2(-R1(3,1),sqrt((R1(3,2))^2+(R1(3,3))^2));
gamma_R1 = atan2(R1(3,2)/cos(beta_R1), R1(3,3)/cos(beta_R1));
alpha_R1 = atan2(R1(2,1)/cos(beta_R1), R1(1,1)/cos(beta_R1));

beta_R2 = atan2(-R2(3,1),sqrt((R2(3,2))^2+(R2(3,3))^2));
gamma_R2 = atan2(R2(3,2)/cos(beta_R2), R2(3,3)/cos(beta_R2));
alpha_R2 = atan2(R2(2,1)/cos(beta_R2), R2(1,1)/cos(beta_R2));

disp("R_1")
disp("alpha: "+ alpha_R1)
disp("beta: "+ beta_R1)
disp("gamma: "+ gamma_R1)
disp(" ")
disp("R_via")
disp("alpha: "+ alpha_Rvia)
disp("beta: "+ beta_Rvia)
disp("gamma: "+ gamma_Rvia)
disp(" ")
disp("R_2")
disp("alpha: "+ alpha_R2)
disp("beta: "+ beta_R2)
disp("gamma: "+ gamma_R2)

%% cubic spline rest-to-rest

%Intervalli di tempo
T1 = 2.5; % Durata dal R1 a Rvia
T2 = 1;   % Durata dal Rvia a R2
T = T1 + T2; % Tempo totale

% Sostituzione dei valori degli angoli
theta1_alpha = alpha_R1; 
theta_v_alpha = alpha_Rvia; 
theta2_alpha = alpha_R2;

theta1_beta = beta_R1; 
theta_v_beta = beta_Rvia; 
theta2_beta = beta_R2;

theta1_gamma = gamma_R1; 
theta_v_gamma = gamma_Rvia; 
theta2_gamma = gamma_R2;

% Definizione delle spline cubiche per ciascun angolo di Eulero
[a1_alpha, b1_alpha, a2_alpha, b2_alpha, v_alpha] = compute_spline(theta1_alpha, theta_v_alpha, theta2_alpha, T1, T2);
[a1_beta, b1_beta, a2_beta, b2_beta, v_beta] = compute_spline(theta1_beta, theta_v_beta, theta2_beta, T1, T2);
[a1_gamma, b1_gamma, a2_gamma, b2_gamma, v_gamma] = compute_spline(theta1_gamma, theta_v_gamma, theta2_gamma, T1, T2);

% Funzioni spline per alpha, beta, gamma
alpha_t = get_spline_function(a1_alpha, b1_alpha, theta1_alpha, a2_alpha, b2_alpha, theta2_alpha, T1, T2);
beta_t = get_spline_function(a1_beta, b1_beta, theta1_beta, a2_beta, b2_beta, theta2_beta, T1, T2);
gamma_t = get_spline_function(a1_gamma, b1_gamma, theta1_gamma, a2_gamma, b2_gamma, theta2_gamma, T1, T2);

% Stampare la forma generale delle funzioni alpha(t), beta(t), gamma(t)
get_spline_function_display(a1_alpha, b1_alpha, theta1_alpha, a2_alpha, b2_alpha, theta2_alpha, "ALPHA(t)");
get_spline_function_display(a1_beta, b1_beta, theta1_beta, a2_beta, b2_beta, theta2_beta, "BETA(t)");
get_spline_function_display(a1_gamma, b1_gamma, theta1_gamma, a2_gamma, b2_gamma, theta2_gamma, "GAMMA(t)");

% Intervallo di tempo per il plot
time1 = linspace(0, T1, 100);
time2 = linspace(T1, T, 100);

% Calcolo dei valori di alpha, beta, gamma nel tempo
alpha_values1 = double(subs(alpha_t, t, time1));
alpha_values2 = double(subs(alpha_t, t, time2));
beta_values1 = double(subs(beta_t, t, time1));
beta_values2 = double(subs(beta_t, t, time2));
gamma_values1 = double(subs(gamma_t, t, time1));
gamma_values2 = double(subs(gamma_t, t, time2));

% Plot dei risultati
figure;
subplot(3,1,1);
plot(time1, alpha_values1, 'b', time2, alpha_values2, 'r');
title('Evoluzione di alpha(t)');
xlabel('Tempo [s]');
ylabel('Alpha [rad]');

subplot(3,1,2);
plot(time1, beta_values1, 'b', time2, beta_values2, 'r');
title('Evoluzione di beta(t)');
xlabel('Tempo [s]');
ylabel('Beta [rad]');

subplot(3,1,3);
plot(time1, gamma_values1, 'b', time2, gamma_values2, 'r');
title('Evoluzione di gamma(t)');
xlabel('Tempo [s]');
ylabel('Gamma [rad]');

% Funzione per calcolare i coefficienti delle spline cubiche
function [a1, b1, a2, b2, v] = compute_spline(theta1, theta_v, theta2, T1, T2)
    syms a1 b1 a2 b2 v real
    eq1 = a1 + b1 + theta1 == theta_v;
    eq2 = (1/T1)*(3*a1 + 2*b1) == v;
    eq3 = -a2 + b2 + theta2 == theta_v;
    eq4 = (1/T2)*(3*a2 - 2*b2) == v;
    eq5 = (1/T1^2)*(6*a1 + 2*b1) == (1/T2^2)*(-6*a2 + 2*b2);

    sol = solve([eq1, eq2, eq3, eq4, eq5], [a1, b1, a2, b2, v]);
    a1 = double(sol.a1);
    b1 = double(sol.b1);
    a2 = double(sol.a2);
    b2 = double(sol.b2);
    v = double(sol.v);
end

% Funzione per ottenere la funzione spline
function get_spline_function_display(a1_in, b1_in, theta1_in, a2_in, b2_in, theta2_in, out)
    syms tau_1 tau_2 a1 a2 b1 b2 theta1 theta2
    theta1_t = a1 * tau_1^3 + b1 * tau_1^2 + theta1;
    theta2_t = a2 * (tau_2 - 1)^3 + b2 * (tau_2 - 1)^2 + theta2;
    
    disp(" ")
    disp("funzioni di "+ out)
    disp(simplify(subs(theta1_t,[a1,b1,theta1],[a1_in,b1_in,theta1_in]),steps=100))
    disp(simplify(subs(theta2_t,[a2,b2,theta2],[a2_in,b2_in,theta2_in]),steps=100))
end


% Funzione per ottenere la funzione spline
function spline_func = get_spline_function(a1, b1, theta1, a2, b2, theta2, T1, T2)
    syms t
    tau_1 = t / T1;
    tau_2 = (t - T1) / T2;
    theta1_t = a1 * tau_1^3 + b1 * tau_1^2 + theta1;
    theta2_t = a2 * (tau_2 - 1)^3 + b2 * (tau_2 - 1)^2 + theta2;

    spline_func = piecewise(t < T1, theta1_t, t >= T1, theta2_t);
end
