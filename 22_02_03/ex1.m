clear all
clc

syms alpha d d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6 q7 d1 d2 d3 d4 d5 d7

%% number of joints 
N=7;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ pi/2   0   d1   q1;
           -pi/2   0   0    q2;
            pi/2   0   d3   q3;
            pi/2   0   0    q4;
            -pi/2  0   d5   q5;
            pi/2   0   0    q6;
              0    0   d7   q7];

         
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

p = T(1:3,4);

n = T(1:3,1);

s = T(1:3,2);

a = T(1:3,3);

A_0_1 = A{1};

A_0_2 = A{1} * A{2};

A_0_3 = A{1} * A{2} * A{3};

A_0_4 = A{1} * A{2} * A{3} * A{4};

A_0_5 = A{1} * A{2} * A{3} * A{4} * A{5};

A_0_6 = A{1} * A{2} * A{3} * A{4} * A{5} * A{6};

A_0_7 = A{1} * A{2} * A{3} * A{4} * A{5} * A{6} * A{7};

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);
p_04 = A_0_4(1:3, end);
p_05 = A_0_5(1:3, end);
p_06 = A_0_6(1:3, end);
p_07 = A_0_7(1:3, end);

p_0_E = p_07;
p_1_E = p_07 - p_01;
p_2_E = p_07 - p_02;
p_3_E = p_07 - p_03;
p_4_E = p_07 - p_04;
p_5_E = p_07 - p_05;
p_6_E = p_07 - p_06;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);
R_0_4 = A_0_4(1:3, 1:3);
R_0_5 = A_0_4(1:3, 1:3);
R_0_6 = A_0_4(1:3, 1:3);
R_0_7 = simplify(A_0_4(1:3, 1:3), steps=100)



% ho scritto questo codice ma non serve 
