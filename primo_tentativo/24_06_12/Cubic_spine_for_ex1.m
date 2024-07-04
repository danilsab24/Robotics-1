clc
clear all

syms t T_time alfa beta gamma Ca0 Ca1 Ca2 Ca3 tau phi_in phi_f phi_vel_in phi1 phi2 omega1 omega2

% usiamo questo metodo Euler
R_in_0 = [0.5 , 0 , -sqrt(3)/2;
         -sqrt(3)/2, 0 , -0.5;
         0,      1 ,       0];

R_fin_T = [sqrt(2)/2 , -sqrt(2)/2 , 0;
           -0.5 , -0.5 , -sqrt(2)/2;
           0.5 , 0.5 , -sqrt(2)/2];

[phi_0_1, phi_0_2] = rotm2eul(R_in_0, "ZXZ");
[phi_T_1, phi_T_2] = rotm2eul(R_fin_T, "ZXZ");

omega_i = [0 ; 1 ; 0];
omega_f = [0 ; 0 ; 1];

% MATRICI DI EULERO ZXZ
R_Z1 = [cos(alfa)   -sin(alfa)  0;
        sin(alfa)    cos(alfa)  0;
            0             0       1];

R_x = [1       0           0;
       0    cos(beta)  -sin(beta);
       0    sin(beta)   cos(beta)];

R_Z2 = [cos(gamma)   -sin(gamma)  0;
        sin(gamma)    cos(gamma)  0;
            0             0       1];

% Matrici iniziali e finali
R_i = [0   0   1;
       0   1   0;
      -1   0   0];

R_f = [sqrt(2)/2    0     sqrt(2)/2;
       sqrt(2)/2    0    -sqrt(2)/2;
           0        1       0];

R_ZXZ = simplify(R_Z1 * R_x * R_Z2, 'Steps', 100);

[phi_0_1, phi_0_2] = rotm2eul(R_i, 'ZXZ');
[phi_T_1, phi_T_2] = rotm2eul(R_f, 'ZXZ');

% Definizione delle traiettorie cubiche
tau = t / T_time;

phi_t = phi_in + Ca0 + Ca1 * tau + Ca2 * tau^2 + Ca3 * tau^3;
phi_vel_t = simplify(diff(phi_t, t), 'Steps', 100);
phi_acc_t = simplify(diff(phi_vel_t, t), 'Steps', 100);

phi_t_0 = simplify(subs(phi_t, t, 0), 'Steps', 100);
phi_t_T = simplify(subs(phi_t, t, T_time), 'Steps', 100);

phi_vel_t_0 = simplify(subs(phi_vel_t, t, 0), 'Steps', 100);
phi_vel_t_T = simplify(subs(phi_vel_t, t, T_time), 'Steps', 100);

phi_acc_t_0 = simplify(subs(phi_acc_t, t, 0), 'Steps', 100);
phi_acc_t_T = simplify(subs(phi_acc_t, t, T_time), 'Steps', 100);

A = [1, 0, 0, 0;
     1, 1, 1, 1;
     0, 1/T_time, 0, 0;
     0, 1, 2/T_time, 3/(T_time^2)];

B = [phi1.';
     phi2.';
     omega1;
     omega2];

matrix = simplify(A\B, 'Steps', 100)

phi_t_Ca = simplify(subs(phi_t, [Ca0, Ca1, Ca2, Ca3], matrix(:).'), 'Steps', 1000);

phi_without = simplify(subs(phi_t_Ca, {phi_in, phi_f, phi_vel_in}, {phi_0_1.', phi_T_1.', omega_i}), 'Steps', 100);

phi_TT = simplify(subs(phi_without, T_time, 1), 'Steps', 100)

phi_T_mid = double(subs(phi_TT, t, 1/2));

R_T_mid = eul2rotm(phi_T_mid.', 'XYZ');

phi_dot_TT = simplify(diff(subs(phi_without, T_time, 1), t), 'Steps', 100);

phi_dot_T_mid = double(subs(phi_dot_TT, t, 0.5));

T_mid = double(subs(R_ZXZ, [alfa, beta, gamma], phi_T_mid.'));

omega_mid = T_mid * phi_dot_T_mid;

% Plot delle traiettorie
T_time_value = 1;
time_steps = linspace(0, T_time_value, 100);
phi_traj = zeros(length(time_steps), 3);

for i = 1:length(time_steps)
    phi_traj(i, :) = double(subs(phi_TT, t, time_steps(i)));
end

figure;
plot3(phi_traj(:, 1), phi_traj(:, 2), phi_traj(:, 3), 'LineWidth', 2);
xlabel('\phi_x');
ylabel('\phi_y');
zlabel('\phi_z');
title('Traiettoria dell''End-Effector');
grid on;
