clear all
clc

syms q1 q2 q3 L

p = [q1+L*cos(q3);
     q2+L*sin(q3);
        q3]
J = jacobian(p, [q1,q2,q3])

inv_J = inv(J)

% Parameters
R = 1; % Radius of the circle
v = 1; % Speed
omega = v / R;
T = 2 * pi / omega; % Period of one full circle
t = linspace(0, T, 1000); % Time vector

% End-effector position
p_x = R * cos(omega * t);
p_y = R * sin(omega * t);

% End-effector velocity
v_x = -R * omega * sin(omega * t);
v_y = R * omega * cos(omega * t);

% End-effector acceleration
a_x = -R * omega^2 * cos(omega * t);
a_y = -R * omega^2 * sin(omega * t);

% Joint positions
q1 = p_x;
q2 = p_y;
q3 = omega * t;

% Joint velocities
q1_dot = v_x;
q2_dot = v_y;
q3_dot = omega * ones(size(t));

% Joint accelerations
q1_ddot = a_x;
q2_ddot = a_y;
q3_ddot = zeros(size(t));

% Plotting
% figure;
% subplot(3,1,1);
% plot(t, p_x, t, p_y);
% title('End-effector Position');
% xlabel('Time [s]');
% ylabel('Position [m]');
% legend('p_x', 'p_y');
% 
% subplot(3,1,2);
% plot(t, v_x, t, v_y);
% title('End-effector Velocity');
% xlabel('Time [s]');
% ylabel('Velocity [m/s]');
% legend('v_x', 'v_y');
% 
% subplot(3,1,3);
% plot(t, a_x, t, a_y);
% title('End-effector Acceleration');
% xlabel('Time [s]');
% ylabel('Acceleration [m/s^2]');
% legend('a_x', 'a_y');

figure;
subplot(3,1,1);
plot(t, q1, t, q2, t, q3);
title('Joint Positions');
xlabel('Time [s]');
ylabel('Position [m or rad]');
legend('q1', 'q2', 'q3');

subplot(3,1,2);
plot(t, q1_dot, t, q2_dot, t, q3_dot);
title('Joint Velocities');
xlabel('Time [s]');
ylabel('Velocity [m/s or rad/s]');
legend('q1\_dot', 'q2\_dot', 'q3\_dot');

subplot(3,1,3);
plot(t, q1_ddot, t, q2_ddot, t, q3_ddot);
title('Joint Accelerations');
xlabel('Time [s]');
ylabel('Acceleration [m/s^2 or rad/s^2]');
legend('q1\_ddot', 'q2\_ddot', 'q3\_ddot');

