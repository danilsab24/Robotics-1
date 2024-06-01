clear all
clc

disp("DH per ROBOT A o ROBOT B")
input_char = input('inserire: "a" o "b": ', 's');

if strcmp(input_char, 'a')
    %% FOR ROBOT A
    syms alpha d d1  a a1 a2 a3 a4 theta q1 q2 L val_1 val_2 val_3
    
    %% number of joints 
    N=2;
    
    
    %% PAY ATTENTION TO THE POSITION OF
    %% a and d: a is the second column
    %% d the third!
    
    DHTABLE = [ 0   L   0    q1;
                0   L   0    q2];
    
    
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
    
    A_0_2 = simplify(A{1} * A{2}, steps=100);
    
    p_01 = A_0_1(1:3, end);
    p_02 = A_0_2(1:3, end);
    
    p_0_E = p_02
    p_1_E = p_02 - p_01;
    
    R_0_1 = A_0_1(1:3, 1:3);
    R_0_2 = A_0_2(1:3, 1:3)
    
    R_0_2_subs = eval(subs(R_0_2,[q1,q2,L],[pi/3,-pi/2,1]))
    P_0_E_subs = eval(subs(p_0_E,[q1,q2,L],[pi/3,-pi/2,1]))

    T_A_EA = [R_0_2_subs P_0_E_subs; 
             0   0   0   1]

    T_W_A = [1  0   0   -2.5;
             0  1   0     1;
             0  0   1     0;
             0  0   0     1]
    
    T_W_B = [cos(pi/6)  -sin(pi/6)  0  1;
             sin(pi/6)   cos(pi/6)  0  2;
                0           0       1  0;
                0           0       0  1];
    
    T_W_E = T_W_A*T_A_EA
    
    T_EA_EB = [-1  0 0 0;
                0 -1 0 0;
                0  0 1 0;
                0  0 0 1]
    
    T_B_EA = inv(T_W_B)*T_W_A*T_A_EA*T_EA_EB

    % disp("Inverse kinematics 3R ROBOTO B for find the final value :")
    % syms a1 a2 a3 L
    % 
    % disp("Inverse kinematics 3R ROBOT B for finding the final values:");
    % 
    % % Definisci una funzione anonima per il sistema di equazioni non lineari
    % equations = @(vars) [
    %     cos(vars(1)) + cos(vars(1) + vars(2)) + cos(vars(1) + vars(2) + vars(3)) + 2.1651;
    %     sin(vars(1)) + sin(vars(1) + vars(2)) + sin(vars(1) + vars(2) + vars(3)) - 0.5179;
    %     vars(1) + vars(2) + vars(3) 
    % ];
    % 
    % % Punto di partenza per l'algoritmo di fsolve
    % initial_guess = [0.1, 0.1, 0.1];  % Un punto di partenza ragionevole per gli angoli
    % 
    % % Risolvi il sistema di equazioni non lineari
    % options = optimoptions('fsolve', 'Display', 'iter');
    % [solution, fval, exitflag, output] = fsolve(equations, initial_guess, options);
    % 
    % % Visualizza le soluzioni
    % disp('Soluzioni:');
    % disp(['a1 = ', num2str(solution(1))]);
    % disp(['a2 = ', num2str(solution(2))]);
    % disp(['a3 = ', num2str(solution(3))]);
    % 
    % % Visualizza il valore delle funzioni alle soluzioni trovate
    % disp('Valore delle funzioni alle soluzioni trovate:');
    % disp(fval);
end

if strcmp(input_char, 'b')
    %% FOR ROBOT B
    
    syms alpha d d1  a a1 a2 a3 a4 theta q1 q2 q3 L
    
    %% number of joints 
    N=3;
    
    
    %% PAY ATTENTION TO THE POSITION OF
    %% a and d: a is the second column
    %% d the third!
    
    DHTABLE = [ 0   L   0    q1;
                0   L   0    q2;
                0   L   0    q3];
    
    
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
    p_03 = A_0_3(1:3, end)
    
    p_0_E = simplify(p_03, steps=100)
    p_1_E = p_03 - p_01;
    p_2_E = p_03 - p_01;
    
    R_0_1 = A_0_1(1:3, 1:3);
    R_0_2 = A_0_2(1:3, 1:3);
    R_0_3 = simplify(A_0_3(1:3, 1:3),steps=100) 

    T_B_EA_q = [R_0_3  p_03;
                0  0  0   1]
end

