
clear all
clc
% 
 syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6

%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [    pi/2    0    0    q1;
               0    a2   0    q2;
            0   a3   0    q3];


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

A_0_3 = simplify(A{1} * A{2} * A{3},steps=100);

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);

p_0_E = p_03;
p_1_E = p_03 - p_01;
p_2_E = p_03 - p_02;
p_3_E = p_03 - p_03;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);

z_0 = [0;
       0;
       1];

z_1 = simplify(R_0_1*z_0, Steps=100);
z_2 = simplify(R_0_2*z_0, Steps=100);

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100);
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100);
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100);


%% TO MODIFY BASED ON THE TYPE OF JOINTS
J_L_A = [p_z_0, p_z_1, p_z_2;
         z_0, z_1, z_2]


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


J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
J_L_A_mid_frame_3 = simplify(rotation_mid_frame_3.' * J_L_A, steps=100)

vedi = simplify(J_L_A(1:3,1:3),steps=100)
det_J = simplify(det(J_L_A(1:3,1:3)),steps=100)

sol = solve(det_J == 0, [q2,q3])
disp("soluzioni")
disp(sol.q2)
disp(sol.q3)

vedi_II = subs(vedi,q3,0)
rank_J_subs = rank(subs(vedi,q3,0))
NULL_J = null(vedi_II)
RANGE_J = simplify(colspace(vedi_II),steps=100)

% det_J_frame_0 = simplify(det(J_L_A.' * J_L_A), steps=100)
% det_J_frame_1 = simplify(det(J_L_A_mid_frame_1.' * J_L_A_mid_frame_1), steps=100)
% det_J_frame_2 = simplify(det(J_L_A_mid_frame_2.' * J_L_A_mid_frame_2), steps=100)
% det_J_frame_3 = simplify(det(J_L_A_mid_frame_3.' * J_L_A_mid_frame_3), steps=100)


% p = [a2*cos(q1) + a3*cos(q1+q2);
%      a2*sin(q1) + a3*sin(q1+q2);
%          q1+q2+q3]
% 
% J = jacobian(p,[q1,q2,q3])
% 
% det_J = simplify(det(J),steps=100)
% 
% J_I = subs(J,q2,0)
% 
% null_J_I = null(J_I)
% range_J_I = colspace(J_I)

% consider a digital camera with a number of p

