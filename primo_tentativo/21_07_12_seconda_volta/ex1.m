
clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 B D A C

%% number of joints 
N=4;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ pi/2   B   A    q1;
            0      C   0    q2;
            pi/2   D   0    q3;
            0      0   q4   0];

         
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

A_0_2 = A{1} * A{2};

A_0_3 = A{1} * A{2} * A{3};

A_0_4 = simplify(A{1} * A{2} * A{3} * A{4}, steps = 100);

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);
p_04 = simplify(A_0_4(1:3, end), steps=100)

R_W0 = [0 -1 0;
        1  0 0;
        0  0 1]

P_w4 = simplify(R_W0*p_04, steps=100)

p_0_E = p_04;
p_1_E = p_04 - p_01;
p_2_E = p_04 - p_02;
p_3_E = p_04 - p_03;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);
R_0_4 = A_0_4(1:3, 1:3);

z_0 = [0;
       0;
       1];

z_1 = simplify(R_0_1*z_0, Steps=100);
z_2 = simplify(R_0_2*z_0, Steps=100);
z_3 = simplify(R_0_3*z_0, Steps=100);

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100);
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100);
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100);
p_z_3 = simplify(cross(z_3, p_3_E), steps = 100);


%% TO MODIFY BASED ON THE TYPE OF JOINTS
J_L_A = [p_z_0, p_z_1, p_z_2, z_3;
         z_0, z_1, z_2, [0;0;0]];

J_L_A_simp = simplify(J_L_A, steps=100)

rotation_mid_frame_1 = [R_0_1, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_1];


rotation_mid_frame_2 = [R_0_2, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_2];



rotation_mid_frame_3 = [R_0_3, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_3];



rotation_mid_frame_4 = [R_0_4, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_4];



% J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
% J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
% J_L_A_mid_frame_3 = simplify(rotation_mid_frame_3.' * J_L_A, steps=100)
% J_L_A_mid_frame_4 = simplify(rotation_mid_frame_4.' * J_L_A, steps=100)
% 
% 
% det_J_frame_0 = simplify(det(J_L_A.' * J_L_A), steps=100)
% det_J_frame_1 = simplify(det(J_L_A_mid_frame_1.' * J_L_A_mid_frame_1), steps=100)
% det_J_frame_2 = simplify(det(J_L_A_mid_frame_2.' * J_L_A_mid_frame_2), steps=100)
% det_J_frame_3 = simplify(det(J_L_A_mid_frame_3.' * J_L_A_mid_frame_3), steps=100)
% det_J_frame_4 = simplify(det(J_L_A_mid_frame_4.' * J_L_A_mid_frame_4), steps=100)

J_L = J_L_A_simp(1:3, 1:4)
J_L_red = simplify(subs(J_L,[B,D],[0,0]))
% det_J_L_red = simplify(det(J_L_red*J_L_red.'), steps=100)

angles = [0, pi, -pi, -pi/2, pi/2]
find_angles = false
for alpha = angles 
    J_L_red_subs = subs(J_L_red, [q1,q2,q3,q4], [alpha,0,0,0]);
    rank_J_L_red_subs = rank(J_L_red_subs);
    if rank_J_L_red_subs < 3 
        find_angles = true
        disp("angoli trovati: ");
        disp("q1: "+alpha)
    end
end

if find_angles == false 
    for alpha = angles
        for beta = angles
            J_L_red_subs = subs(J_L_red, [q1,q2,q3,q4], [0,alpha, beta,0]);
            rank_J_L_red_subs = rank(J_L_red_subs);
            if rank_J_L_red_subs < 3 
                find_angles = true
                disp("angoli trovati: ");
                disp("q2: "+alpha);
                disp("q3: "+beta);
            end
        end
    end
end
if find_angles == false 
    for alpha = angles
        for beta = angles
            for gamma = angles
                J_L_red_subs = subs(J_L_red, [q1,q2, q3], [alpha, beta, gamma]);
                rank_J_L_red_subs = rank(J_L_red_subs);
                if rank_J_L_red_subs < 3 
                    find_angles = true
                    disp("angoli trovati: ");
                    disp("q1: "+alpha);
                    disp("q2: "+beta);
                    disp("q3: "+gamma);
                end
            end
        end
    end
end
if find_angles == false 
    disp("angoli non trovati");
end


q_s = [pi/2,0,0,0]
J_L_red_subs_singularity = subs(J_L_red_subs,[q1,q2,q3,q4],q_s) 
v_star = colspace(J_L_red_subs_singularity)
v_star_1 = [0;0;-1]

q_dot_star = simplify(pinv(J_L_red_subs_singularity)*v_star_1, steps=100)