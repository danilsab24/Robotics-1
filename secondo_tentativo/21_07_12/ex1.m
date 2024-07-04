clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4  A B C D

%% number of joints 
N=4;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [  pi/2   B   A    q1;
             0      C   0    q2;
             pi/2   D   0    q3;
             0      0   q4    0];

         
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
p_04 = simplify(A_0_4(1:3, end),steps=100);

R_i = [0 -1 0;
       1  0 0;
       0  0 1];

p_w4 = simplify(R_i*p_04,steps=100)

p_0_E = p_04;
p_1_E = p_04 - p_01;
p_2_E = p_04 - p_02;
p_3_E = p_04 - p_03;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);
R_0_4 = A_0_4(1:3, 1:3);


z_0 = [0;0;1];
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

J_simp = simplify(J_L_A, steps=100)

J_red = subs(J_simp(1:3,1:4),[B,D],[0,0])


%code for singularities

ang = [0,pi,pi/2,-pi/2];
for alpha=ang 
    for beta=ang 
        J_red_subs = subs(J_red,[q2,q3],[alpha,beta]);
        r = rank(J_red_subs);
        if r <= 2
            disp("angoli trovati")
            disp("q2: "+ alpha)
            disp("q3: "+ beta)
        end
    end
end

J_red_subs_sing = subs(J_red,[q1,q2,q3,q4],[0,pi/2,pi/2,0])
RANGE_SPACE = colspace(J_red_subs_sing)

q_dot = pinv(J_red_subs_sing)*[0;0;1]