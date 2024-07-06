clear all
clc

syms q1 q2 q3 L

p = [q1+L*cos(q2)+L*cos(q2+q3);
         L*sin(q2)+L*sin(q2+q3);
               q2+q3]
%% for find q_in
% e1 = q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3) == 1;
% e2 = (0.5)*sin(q2)+(0.5)*sin(q2+q3) == 0;
% e3 = q2+q3 == pi/4;
% 
% sol_II = solve([e1,e2,e3],[q1,q2,q3])
% disp("soluzioni")
% disp("q1")
% disp(eval(sol_II.q1(1)))
% disp(eval(sol_II.q1(2)))
% disp("q2")
% disp(eval(sol_II.q2(1)))
% disp(eval(sol_II.q2(2)))
% disp("q3")
% disp(eval(sol_II.q3(1)))
% disp(eval(sol_II.q3(2)))

%% for find q_fin
e1 = q1+(0.5)*cos(q2)+(0.5)*cos(q2+q3) == 1;
e2 = (0.5)*sin(q2)+(0.5)*sin(q2+q3) == 0;
e3 = q2+q3 == -pi/4;

sol_II = solve([e1,e2,e3],[q1,q2,q3])
disp("soluzioni")
disp("q1")
disp(eval(sol_II.q1(1)))
disp(eval(sol_II.q1(2)))
disp("q2")
disp(eval(sol_II.q2(1)))
disp(eval(sol_II.q2(2)))
disp("q3")
disp(eval(sol_II.q3(1)))
disp(eval(sol_II.q3(2)))

%% trajectory planning and graph

% Parametri del robot
L = 0.5; % lunghezza dei link
T = 10; % tempo totale per il movimento

% Condizioni iniziali e finali
r_i = [2*L, 0, pi/4];
r_f = [2*L, 0, -pi/4];

% Tempo
t = linspace(0, T, 1000);

% Funzione per calcolare i coefficienti di una cubica rest-to-rest
cubic_coefficients = @(q_i, q_f, T) [q_i, 0, (3*(q_f - q_i)) / T^2, (-2*(q_f - q_i)) / T^3];

% Traiettoria del giunto prismatico q1 (rimane costante)
q1d = 2 * L * ones(size(t));

% Calcolo della traiettoria cubica per q3
a_q3 = cubic_coefficients(pi/4, -pi/4, T);
q3d = a_q3(1) + a_q3(2) * t + a_q3(3) * t.^2 + a_q3(4) * t.^3;

% Calcolo della traiettoria del giunto rotativo q2
q2d = zeros(size(t));
for i = 1:length(t)
    q2d(i) = atan2(0 - L*sin(q3d(i)), 2*L - L*cos(q3d(i)));
end

% Tracciamento delle traiettorie delle giunture
figure;

subplot(3, 1, 1);
plot(t, q1d);
xlabel('Tempo (s)');
ylabel('q1 (m)');
title('Traiettoria del giunto prismatico q1');

subplot(3, 1, 2);
plot(t, q2d);
xlabel('Tempo (s)');
ylabel('q2 (rad)');
title('Traiettoria del giunto rotativo q2');

subplot(3, 1, 3);
plot(t, q3d);
xlabel('Tempo (s)');
ylabel('q3 (rad)');
title('Traiettoria del giunto rotativo q3');