clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 A D beta B C theta1 theta2 J

%% number of joints 
N=2;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ 0   J   0    q1;
            0   D   0    q2];

         
TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
        sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
          0             sin(alpha)             cos(alpha)            d;
          0               0                      0                   1];

A = cell(1,N);

for i = 1:N 
    alpha = DHTABLE(i,1);
    a = DHTABLE(i,2);
    d = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = subs(TDH);
    disp(i)
    disp(A{i})
end


T = eye(4);

for i=1:N 
    T = T*A{i};
    T = simplify(T);
end

T0N = T;

p = T(1:3,4);

n = T(1:3,1);

s = T(1:3,2);

a = T(1:3,3);

A_0_1 = A{1};

A_0_2 = A{1} * A{2}

p_01 = A_0_1(1:3, end);
p_02 = simplify(A_0_2(1:3, end),steps=100)

p_0_E = p_02
p_1_E = p_02 - p_01;

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = simplify(A_0_2(1:3, 1:3), steps=100)

z_0 = [0;
       0;
       1]

z_1 = simplify(R_0_1*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)


%% TO MODIFY BASED ON THE TYPE OF JOINTS
J_L_A = [p_z_0, p_z_1;
         z_0, z_1]


% rotation_mid_frame_1 = [R_0_1, [0, 0, 0; 
%                                   0, 0, 0; 
%                                   0, 0, 0;];
%                         [0, 0, 0; 
%                          0, 0, 0; 
%                          0, 0, 0;], R_0_1]
% 
% 
% rotation_mid_frame_2 = [R_0_2, [0, 0, 0; 
%                                   0, 0, 0; 
%                                   0, 0, 0;];
%                         [0, 0, 0; 
%                          0, 0, 0; 
%                          0, 0, 0;], R_0_2]


% J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
% J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
% 
% 
% det_J_frame_0 = simplify(det(J_L_A.' * J_L_A), steps=100)
% det_J_frame_1 = simplify(det(J_L_A_mid_frame_1.' * J_L_A_mid_frame_1), steps=100)

R_2E = [cos(beta)  -sin(beta)  0;
        sin(beta)   cos(beta)  0;
           0           0       1]

%R_0E = simplify(R_0_2*R_2E, steps=100)

%primary workspace

A = 2;
B = 0.5;
C = 1;

% Define the end-effector position in terms of the joint angles and link lengths
x = A * cos(theta1) + B * cos(theta1 + theta2) + C * cos(theta1 + theta2 + pi/2);
y = A * sin(theta1) + B * sin(theta1 + theta2) + C * sin(theta1 + theta2 + pi/2);

% Create a meshgrid for theta1 and theta2
[theta1_vals, theta2_vals] = meshgrid(linspace(0, 2*pi, 100), linspace(0, 2*pi, 100));

% Calculate the end-effector positions for each combination of theta1 and theta2
x_vals = double(subs(x, {theta1, theta2}, {theta1_vals, theta2_vals}));
y_vals = double(subs(y, {theta1, theta2}, {theta1_vals, theta2_vals}));

% Plot the primary workspace
figure;
plot(x_vals(:), y_vals(:), '.');
title('Primary Workspace of the Planar 2R Robot');
xlabel('x');
ylabel('y');
axis equal;
grid on;

% Annotate the plot with symbolic values
annotation('textbox', [0.15, 0.8, 0.1, 0.1], 'String', 'A', 'EdgeColor', 'none');
annotation('textbox', [0.5, 0.8, 0.1, 0.1], 'String', 'B', 'EdgeColor', 'none');
annotation('textbox', [0.85, 0.8, 0.1, 0.1], 'String', 'C', 'EdgeColor', 'none');

v = J_L_A(1:2, 1:2)
det_v = simplify(det(v), steps=100)

% caso q2=0
v_1 = subs(v, q2, 0)
null_space_v_1 = null(v_1)
range_space_v_1 = colspace(v_1)

% caso q2=pi
v_2 = subs(v, q2, pi)
null_space_v_2 = null(v_2)
range_space_v_2 = colspace(v_2)

%penultimo punto
% Example usage:
xe = 0.6 % End-effector x position
ye = -0.5 % End-effector y position
g = 0.6 % Length of the first link
b = 0.3 % Length of the second link
c = 0.4
d = sqrt(b^2 + c^2)

c2 = (xe^2 +ye^2 -d^2 -g^2)/(2*d*g)
s2_pos = sqrt(1-c2*2)
s2_neg = -sqrt(1-c2*2)
q2_I = atan2(s2_pos, c2);
q2_II = atan2(s2_neg, c2);

c1 = xe*(g+d*cos(q2_I))+ye*d*sin(q2_I)
s1_pos = ye*(g+d*cos(q2_I))-xe*d*sin(q2_I)
s1_neg = ye*(g+d*cos(q2_II))-xe*d*sin(q2_II)
q1_I = atan2(s1_pos, c1);
q1_II = atan2(s1_neg, c1);

disp("soluzioni angoli:")
disp("q1_I: "+q1_I)
disp("q2_I: "+q2_I)
disp("q1_II: "+q1_II)
disp("q2_II: "+q2_II)

v_e = [1;0]
v_subs_I = subs(v,[q1,q2,J,D],[q1_I,q2_I,g,d]);
J_inv_I = inv(v_subs_I);
q_dot_I = eval(J_inv_I*v_e)

v_subs_II = subs(v,[q1,q2,J,D],[q1_II,q2_II,g,d]);
J_inv_II = inv(v_subs_II);
q_dot_II = eval(J_inv_II*v_e)
