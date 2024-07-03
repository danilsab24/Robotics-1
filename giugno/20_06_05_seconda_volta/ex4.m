clear all
clc

% Initial and goal configurations
qs = [0, -pi/2];
qg = [-pi/2, pi/2];

% Bounds on joint velocities and accelerations
V1 = 1; % [rad/s]
V2 = 2; % [rad/s]
A1 = 1.5; % [rad/s^2]
A2 = 2; % [rad/s^2]

% Time duration
Tf = 2; % Total time duration

% Time vector
t = linspace(0, Tf, 100);

% Quintic polynomial coefficients
% Quintic polynomial: q(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5

% Coefficients for joint 1
a0_1 = qs(1);
a1_1 = 0; % Initial velocity
a2_1 = 0; % Initial acceleration
a3_1 = (20*qg(1) - 20*qs(1)) / (2*Tf^3);
a4_1 = (-30*qg(1) + 30*qs(1)) / (2*Tf^4);
a5_1 = (12*qg(1) - 12*qs(1)) / (2*Tf^5);

% Coefficients for joint 2
a0_2 = qs(2);
a1_2 = 0; % Initial velocity
a2_2 = 0; % Initial acceleration
a3_2 = (20*qg(2) - 20*qs(2)) / (2*Tf^3);
a4_2 = (-30*qg(2) + 30*qs(2)) / (2*Tf^4);
a5_2 = (12*qg(2) - 12*qs(2)) / (2*Tf^5);

% Position, velocity, and acceleration profiles
q1 = a0_1 + a1_1*t + a2_1*t.^2 + a3_1*t.^3 + a4_1*t.^4 + a5_1*t.^5;
q1_dot = a1_1 + 2*a2_1*t + 3*a3_1*t.^2 + 4*a4_1*t.^3 + 5*a5_1*t.^4;
q1_ddot = 2*a2_1 + 6*a3_1*t + 12*a4_1*t.^2 + 20*a5_1*t.^3;

q2 = a0_2 + a1_2*t + a2_2*t.^2 + a3_2*t.^3 + a4_2*t.^4 + a5_2*t.^5;
q2_dot = a1_2 + 2*a2_2*t + 3*a3_2*t.^2 + 4*a4_2*t.^3 + 5*a5_2*t.^4;
q2_ddot = 2*a2_2 + 6*a3_2*t + 12*a4_2*t.^2 + 20*a5_2*t.^3;

% Plotting
figure;
subplot(3, 1, 1);
plot(t, q1, 'r', t, q2, 'b');
xlabel('Time [s]');
ylabel('Joint Position [rad]');
title('Joint Position Trajectory');
legend('q1', 'q2');

subplot(3, 1, 2);
plot(t, q1_dot, 'r', t, q2_dot, 'b');
xlabel('Time [s]');
ylabel('Joint Velocity [rad/s]');
title('Joint Velocity Trajectory');
legend('q1\_dot', 'q2\_dot');

subplot(3, 1, 3);
plot(t, q1_ddot, 'r', t, q2_ddot, 'b');
xlabel('Time [s]');
ylabel('Joint Acceleration [rad/s^2]');
title('Joint Acceleration Trajectory');
legend('q1\_ddot', 'q2\_ddot');

sgtitle('2R Planar Robot Trajectories with Quintic Polynomials');
