clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6 A B C D 

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

T0N = T

p = T(1:3,4)

n = T(1:3,1)

s = T(1:3,2)

a = T(1:3,3)

A_0_1 = A{1};

A_0_2 = A{1} * A{2};

A_0_3 = A{1} * A{2} * A{3};

A_0_4 = simplify(A{1} * A{2} * A{3} * A{4}, steps = 100);

P = A_0_4(1:3, 4);

J = simplify(jacobian(P, [q1, q2, q3, q4]), Steps=1000)

R_A_0_1 = A_0_1(1:3, 1:3)

% R_A_0_2 = A_0_2(1:3, 1:3)
% 
% R_A_0_3 = A_0_3(1:3, 1:3)
% 
% R_A_0_4 = A_0_4(1:3, 1:3)

J_frame1 = simplify(R_A_0_1.'*J, Steps=1000)

% J_frame2 = simplify(J*R_A_0_2, Steps=1000)
% 
% J_frame3 = simplify(J*R_A_0_3, Steps=1000)
% 
% J_frame4 = simplify(J*R_A_0_4, Steps=1000)

J_red = subs(J_frame1, [B,D], [0,0]) 

det_J_red = simplify(det(J_red.'*J_red), Steps=1000)

J_red_subs = subs(J_red, [q1,q2,q3,q4], [0,pi/2,0,0])

range_J_red_subs = simplify(colspace(J_red_subs), Steps=1000)

J_inv_red_subs = pinv(J_red_subs)

v_star = [1; 0; 0]

q_dot_star = J_inv_red_subs*v_star