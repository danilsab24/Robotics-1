clear all
clc

% Definire gli intervalli di tempo
T1 = 2.5;
T2 = 1;
t1 = linspace(0, T1, 100);
t2 = linspace(T1, T1 + T2, 100);

% Calcolare le variabili di tempo normalizzate
tau1 = t1 / T1;
tau2 = (t2 - T1) / T2;

% Definire le funzioni spline
alpha1 = (207*pi/112)*tau1.^3 - (291*pi/112)*tau1.^2 + (pi/2);
alpha2 = -(101*pi/280)*(tau2 - 1).^3 - (171*pi/280)*(tau2 - 1).^2;

beta1 = -(13*pi/336)*tau1.^3 + (23*pi/112)*tau1.^2;
beta2 = -(41*pi/840)*(tau2 - 1).^3 - (37*pi/280)*(tau2 - 1).^2 + (pi/4);

gamma1 = (31*pi/112)*tau1.^3 - (3*pi/112)*tau1.^2 + (pi/4);
gamma2 = -(53*pi/280)*(tau2 - 1).^3 - (123*pi/280)*(tau2 - 1).^2 + (3*pi/4);

% Unire gli intervalli di tempo e le funzioni spline
t = [t1, t2];
alpha = [alpha1, alpha2];
beta = [beta1, beta2];
gamma = [gamma1, gamma2];

% Tracciare i grafici
figure;

subplot(3,1,1);
plot(t, alpha, 'b');
title('Evoluzione di \alpha(t)');
xlabel('Tempo [s]');
ylabel('\alpha(t) [rad]');

subplot(3,1,2);
plot(t, beta, 'r');
title('Evoluzione di \beta(t)');
xlabel('Tempo [s]');
ylabel('\beta(t) [rad]');

subplot(3,1,3);
plot(t, gamma, 'g');
title('Evoluzione di \gamma(t)');
xlabel('Tempo [s]');
ylabel('\gamma(t) [rad]');
