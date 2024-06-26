
clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 Ll2 Ll3 Lr2 Lr3 L1

%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ 0   L1    0   q1;
            0   Ll2   0   q2;
            0   Ll3   0   q3];

% in caso si volesse usare l'altro braccio
% DHTABLE = [ 0   L1    0   q1;
%             0   Lr2   0   q2;
%             0   Lr3   0   q3];

         
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

A_0_1 = A{1}

A_0_2 = A{1} * A{2}

A_0_3 = A{1} * A{2} * A{3}

p_01 = A_0_1(1:3, end)
p_02 = A_0_2(1:3, end)
p_03 = simplify(A_0_3(1:3, end),steps=100)

p_03_top = eval(subs(p_03, [q1,q2,q3,Ll2,L1,Ll3], [-pi/2, pi/2, -(3/4)*pi,0.05,0.05,0.05]))
p_03_down = eval(subs(p_03, [q1,q2,q3,Ll2,L1,Ll3], [-pi/2, -pi/2, (3/4)*pi,0.05,0.05,0.05]))

beta = atan2(p_03_top(2:2,1:1)-p_03_down(2:2,1:1), p_03_top(1:1,1:1)-p_03_down(1:1,1:1))

p_0_E = p_03;
p_1_E = p_03 - p_01;
p_2_E = p_03 - p_02;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);
