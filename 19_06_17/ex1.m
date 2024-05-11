clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6

%% number of joints 
N=6;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ pi/2   a1    d1  q1;
              0    a2   0   q2;
            pi/2   0    0   q3;
            pi/2   0    d4  q4;
            pi/2   0    0   q5;
              0    0    d6  q6]

         
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

A_0_4 = A{1} * A{2} * A{3} * A{4};

A_0_5 = A{1} * A{2} * A{3} * A{4} * A{5};

A_0_6 = A{1} * A{2} * A{3} * A{4} * A{5}* A{6};

A_3_4 = A{4}

p_ex = simplify(A_0_4*[0;0;0;1], steps=100)

% p_01 = A_0_1(1:3, end);
% p_02 = A_0_2(1:3, end);
% p_03 = A_0_3(1:3, end);
% p_04 = A_0_4(1:3, end);
% p_05 = A_0_5(1:3, end);
% p_06 = A_0_6(1:3, end);
% 
% p_0_E = p_04;
% p_1_E = p_04 - p_01;
% p_2_E = p_04 - p_02;
% p_3_E = p_04 - p_03;
% p_4_E = p_05 - p_03;
% p_5_E = p_06 - p_03;
% 
% R_0_1 = A_0_1(1:3, 1:3);
% R_0_2 = A_0_2(1:3, 1:3);
% R_0_3 = A_0_3(1:3, 1:3);
% R_0_4 = A_0_4(1:3, 1:3);
% R_0_5 = A_0_5(1:3, 1:3);
% R_0_6 = A_0_6(1:3, 1:3);
% 
% z_0 = [0;
%        0;
%        1];
% 
% z_1 = simplify(R_0_1*z_0, Steps=100);
% z_2 = simplify(R_0_2*z_0, Steps=100);
% z_3 = simplify(R_0_3*z_0, Steps=100);
% z_4 = simplify(R_0_4*z_0, Steps=100);
% z_5 = simplify(R_0_5*z_0, Steps=100);
% 
% p_z_0 = simplify(cross(z_0, p_0_E), steps = 100);
% p_z_1 = simplify(cross(z_1, p_1_E), steps = 100);
% p_z_2 = simplify(cross(z_2, p_2_E), steps = 100);
% p_z_3 = simplify(cross(z_3, p_3_E), steps = 100)
% p_z_4 = simplify(cross(z_4, p_4_E), steps = 100)
% p_z_5 = simplify(cross(z_5, p_5_E), steps = 100);

%punto d

p_ex_n = subs(p_ex, [d1,d4,a2, a1, q1, q2, q3], [680,1080,870, 150, 0,pi/2,0])

p_x = 1 + 0.5*cos(2*pi*0.25); 
p_y = 1 + 0.5*sin(2*pi*0.25); 
L1 = 1; 
L2 = 1; 
L3 = 1; 
phi = 2*pi*0.25; 

p_wx = p_x - L3*cos(phi);
p_wy = p_y - L3*sin(phi);

cos_q2 = (p_wx^2 + p_wy^2 - L1^2 - L2^2) / (2*L1*L2);
sin_q2_plus = sqrt(1 - cos_q2^2);
sin_q2_neg = -sqrt(1 - cos_q2^2);

q2_plus = atan2(sin_q2_plus,cos_q2);
q2_neg = atan2(sin_q2_neg,cos_q2);

sin_q1_plus = (p_wy*(L1 + L2*cos_q2) - L2*sin_q2_plus*p_wx) / (p_wx^2 + p_wy^2);
sin_q1_neg = (p_wy*(L1 + L2*cos_q2) - L2*sin_q2_neg*p_wx) / (p_wx^2 + p_wy^2);

cos_q1_plus = (p_wx*(L1 + L2*cos_q2) + L2*sin_q2_plus*p_wy) / (p_wx^2 + p_wy^2);
cos_q1_neg = (p_wx*(L1 + L2*cos_q2) + L2*sin_q2_neg*p_wy) / (p_wx^2 + p_wy^2);

q1_plus = atan2(sin_q1_plus,cos_q1_plus);
q1_neg = atan2(sin_q1_neg,cos_q1_neg);

q3_plus = phi - q1_plus - q2_plus;
q3_neg = phi - q1_neg - q2_neg;

disp("First solution:");
q_first = [q1_plus; q2_plus; q3_plus];
disp(q_first);

disp("Second solution:");
q_second = [q1_neg; q2_neg; q3_neg];
disp(q_second);