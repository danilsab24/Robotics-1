
clear all 
clc

% Parameters
M = 2;          % Mass [kg]
Umax = 8;       % Maximum force [N]
xi = 0;         % Initial position [m]
vi = -2;        % Initial velocity [m/s]
xf = 3;         % Final position [m]
vf = 0;         % Final velocity [m/s]

% Calculate the acceleration
a_max = Umax / M;

% Calculate the time to reach maximum velocity (T/2)
T_half = sqrt((xf - xi) / (0.5 * a_max) + (vi / a_max)^2);

% Total time
T = 2 * T_half;

% Time vectors
t1 = linspace(0, T_half, 100);
t2 = linspace(T_half, T, 100);
t = [t1, t2(2:end)];  % Combine the two phases

% Velocity vectors (triangular profile)
v_t1 = vi + a_max * t1;
v_t2 = v_t1(end) - a_max * (t2 - T_half);

% Position vectors (using uniformly accelerated motion equations)
x_t1 = xi + vi * t1 + 0.5 * a_max * t1.^2;
x_t2 = x_t1(end) + v_t1(end) * (t2 - T_half) - 0.5 * a_max * (t2 - T_half).^2;

% Acceleration vectors
a_t1 = a_max * ones(size(t1));
a_t2 = -a_max * ones(size(t2));

% Combine position, velocity, and acceleration vectors
x = [x_t1, x_t2(2:end)];
v = [v_t1, v_t2(2:end)];
a = [a_t1, a_t2(2:end)];

% Plotting
figure;
subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Position x(t) [m]');
title('Position vs. Time');
grid on;

subplot(3,1,2);
plot(t, v, 'r', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Velocity v(t) [m/s]');
title('Velocity vs. Time');
grid on;

subplot(3,1,3);
plot(t, a, 'g', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Acceleration a(t) [m/s^2]');
title('Acceleration vs. Time');
grid on;




