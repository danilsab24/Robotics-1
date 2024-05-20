
clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 L M n

%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ 0      L   0    q1;
            pi/2   0   M    q2;
            0      n   0    q3];

         
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

A_0_3 = simplify(A{1} * A{2} * A{3}, steps=100)

p_01 = A_0_1(1:3, end)
p_02 = A_0_2(1:3, end)
p_03 = A_0_3(1:3, end)

p_0_E = p_03
p_1_E = p_03 - p_01
p_2_E = p_03 - p_02

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = A_0_2(1:3, 1:3)
R_0_3 = A_0_3(1:3, 1:3)

z_0 = [0;
       0;
       1]

z_1 = simplify(R_0_1*z_0, Steps=100)
z_2 = simplify(R_0_2*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100)

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



% J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
% J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
% J_L_A_mid_frame_3 = simplify(rotation_mid_frame_3.' * J_L_A, steps=100)
% 
% 
% det_J_frame_0 = simplify(det(J_L_A.' * J_L_A), steps=100)
% det_J_frame_1 = simplify(det(J_L_A_mid_frame_1.' * J_L_A_mid_frame_1), steps=100)
% det_J_frame_2 = simplify(det(J_L_A_mid_frame_2.' * J_L_A_mid_frame_2), steps=100)
% det_J_frame_3 = simplify(det(J_L_A_mid_frame_3.' * J_L_A_mid_frame_3), steps=100)

v_dot = J_L_A(1:3, 1:3)
det_v_dot = simplify(det(v_dot), steps=100)

%prova
v_dot_subs_q3 = subs(v_dot, q3, pi/2)
rank_v_dot_subs_q3 = rank(v_dot_subs_q3)

v_dot_subs_q2_0 = subs(v_dot, q2, 0)
rank_v_dot_subs_q2_0 = rank(v_dot_subs_q2_0)
v_dot_subs_q2_pi = subs(v_dot, q2, pi)
rank_v_dot_subs_q2_pi = rank(v_dot_subs_q2_pi) 

%cerca rank=1

% Valori di q1, q2, q3 da provare
q_values = [0, pi, pi/2, -pi/2];

% Ricerca della configurazione desiderata
found_solution = false;
for q1_val = q_values
    for q2_val = q_values
        for q3_val = q_values
            % Calcolo della matrice v_dot per la combinazione corrente
            v_dot_val = subs(v_dot, [q1, q2, q3], [q1_val, q2_val, q3_val]);
            % Calcolo del rango della matrice v_dot
            rank_v_dot = rank(v_dot_val);
            % Verifica se il rango è 1
            if rank_v_dot == 1
                disp('Configurazione trovata:');
                disp(['q1 = ', num2str(q1_val)]);
                disp(['q2 = ', num2str(q2_val)]);
                disp(['q3 = ', num2str(q3_val)]);
                disp('Matrice v_dot:');
                disp(v_dot_val);
                found_solution = true;
                break;
            end
        end
        if found_solution
            break;
        end
    end
    if found_solution
        break;
    end
end

if ~found_solution
    disp('Nessuna configurazione trovata con rango 1.');
end

v_dot_subs_rank_1 = simplify(subs(v_dot, [q2,q3], [pi/2,pi/2]), Steps=100)
range_space_v_dot = colspace(v_dot_subs_rank_1)
