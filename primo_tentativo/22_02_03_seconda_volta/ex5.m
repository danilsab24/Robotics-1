clear all
clc

% Given data
theta_dot_m = 10; % Motor angular speed in rad/s
r1 = 20; % Radius of gear 1 in mm
r2 = 60; % Radius of gear 2 in mm
r3 = 8; % Radius of pulley 3 in mm
r4 = 32; % Radius of pulley 4 in mm

% Conversion factor from mm to m
mm_to_m = 1 / 1000;

% Radii in meters
r1 = r1 * mm_to_m;
r2 = r2 * mm_to_m;
r3 = r3 * mm_to_m;
r4 = r4 * mm_to_m;

% Transmission ratios
gear_ratio = r1 / r2;
pulley_ratio = r3 / r4;

% Link angular speed
theta_dot_link = theta_dot_m * gear_ratio * pulley_ratio;

% Angle to rotate (90 degrees in radians)
theta = pi / 2;

% Time to rotate by 90 degrees
T_theta = theta / theta_dot_link;

%result
fprintf('Time required for the link to rotate by 90 degrees: %.3f seconds\n', T_theta);

direction = 'clockwise';

fprintf('The link will rotate in the %s direction.\n', direction);
