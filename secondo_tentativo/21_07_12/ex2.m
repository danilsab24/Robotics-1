clear all
clc

% Given data
Im = 1.5e-4; % Rotor inertia [kgm^2]
It = 0.5e-2; % Transmission shaft inertia [kgm^2]
Il = 0.8e-1; % Link inertia [kgm^2]
nr1 = 10; % First gearbox reduction ratio
N = 2000; % Encoder pulses per turn
theta_l_d = -pi/4; % Desired angle [rad]
T = 0.5; % Time [s]

% Calculate the optimal value of nr2 that minimizes the motor torque
nr2_opt = sqrt(Il / (It + Im * nr1^2));

% Calculate the angular resolution
Delta_theta_l = (2 * pi / (N * nr1 * nr2_opt))

% Calculate the maximum motor torque for a bang-bang trajectory
Amax = 4 * abs(theta_l_d) / T^2
tau_m = (Im * nr1 * nr2_opt ) + ((It*nr2_opt) / nr1) + (Il / nr1) * (1/nr2_opt)
tau_m_max = tau_m*Amax

% Display results
disp(['Optimal nr2: ', num2str(nr2_opt)]);
disp(['Angular resolution (rad): ', num2str(Delta_theta_l)]);
disp(['Maximum motor torque (Nm): ', num2str(tau_m_max)]);

