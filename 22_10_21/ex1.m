clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 B D A C

%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ pi/2   0   d1   q1;
            pi/2   0   q2   pi/2;
            0      a3  0    q3;];

         
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

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end)

p_0_E = p_03;
p_1_E = p_03 - p_01;
p_2_E = p_03 - p_02;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);

J = simplify(jacobian(p_03,[q1,q2,q3]), steps=100)
det_J = simplify(det(J), steps=100)

J_subs_I = subs(J, q3, 0)
NULL_J_subs_I = null(J_subs_I)
RANGE_J_subs_I = colspace(J_subs_I)
RANGE_J_subs_I_t = null(J_subs_I.')

J_subs_II = subs(J, q3, pi)
NULL_J_subs_II = null(J_subs_II)
RANGE_J_subs_II = colspace(J_subs_II)
RANGE_J_subs_II_t = null(J_subs_II.')

J_subs_III = subs(J, q2, -a3*sin(q3))
NULL_J_subs_III = null(J_subs_III)
RANGE_J_subs_III = colspace(J_subs_III)
RANGE_J_subs_III_t = null(J_subs_III.')