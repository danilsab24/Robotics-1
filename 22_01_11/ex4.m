clear all
clc

syms K D  alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 D K phi alpha1 alpha2 alpha3

% punto i
 
%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ -pi/2  K   0    q1;
            pi/2   0   q2    0;
            0      D   0    q3];

         
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
p_03 = A_0_3(1:3, end)

p_0_E = p_03
p_1_E = p_03 - p_01
p_2_E = p_03 - p_02

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = A_0_2(1:3, 1:3)
R_0_3 = A_0_3(1:3, 1:3)

R_0_3_subs = subs(R_0_3, [q1, q2, q3, K, D], [pi/2, -1, 0, 1, sqrt(2)])

R_3_e = [ 0   -sin(phi) cos(phi);
          0    cos(phi)  sin(phi);
         -1      0         0    ]

R_0_e = subs(R_0_3_subs*R_3_e, phi, -pi/4)

p = [K*cos(q1) + D*cos(q1 + q3) - q2*sin(q1);
     K*sin(q1) + D*sin(q1 + q3) + q2*cos(q1);
     q1 + q3]

J = simplify(jacobian(p, [q1, q2, q3]), Steps=100)

J_subs = simplify(subs(J,[q1, q2, q3, K, D], [pi/2, -1, 0, 1, sqrt(2)]), steps=100)

% Crea una matrice di zeri con 3 righe e lo stesso numero di colonne di J_subs
zero_rows = zeros(3, size(J_subs, 2));

% Suddividi J_subs in due parti
J_subs_top = J_subs(1:2, :);
J_subs_bottom = J_subs(3:end, :);

% Inserisci le righe di zeri tra la seconda e la terza riga
J_subs = [J_subs_top; zero_rows; J_subs_bottom]

J_subs_L = J_subs(1:3, :)
J_subs_A = J_subs(4:end, :)

J_subs_L_e = R_0_e.'*J_subs_L
J_subs_A_e = R_0_e.'*J_subs_A

J_subs_e = eval([J_subs_L_e;J_subs_A_e])

F = [-1; -2; 2]

F_e = [0; -1; -2; 2; 0; 0]

F_e_top = R_0_e*F_e(1:3)
F_e_sub = R_0_e*F_e(4:end)

F_final = eval([F_e_top; F_e_sub])

tau_1 = -transpose(J_subs_e)*F_e

tau_2 = eval(-J_subs.'*F_final)
