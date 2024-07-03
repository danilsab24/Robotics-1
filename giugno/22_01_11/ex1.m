clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 D K phi alpha1 alpha2 alpha3
 
%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ -pi/2  0   K    0;
            pi/2   0   0    0;
            0      D   0    0];

         
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

z_0 = [0;
       0;
       1]

z_1 = simplify(R_0_1*z_0, Steps=100)
z_2 = simplify(R_0_2*z_0, Steps=100)
z_3 = simplify(R_0_3*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100)

% punto vi

% Matrice di rotazione intorno all'asse z
R_x_2 = [1      0          0;
       0   cos(a3)  -sin(a3);
       0   sin(a3)   cos(a3)]


% Matrice di rotazione intorno all'asse y
R_y = [cos(a2), 0, sin(a2);
       0, 1, 0;
       -sin(a2), 0, cos(a2)];

R_x = [1      0          0;
       0   cos(a1)  -sin(a1);
       0   sin(a1)   cos(a1)]

% Calcolo della matrice di rotazione risultante
R_x_y_x = R_x * R_y * R_x_2


risolvi_sistema2()
risolvi_sistema()

function soluzione = risolvi_sistema2()
    % Definizione delle equazioni
    funzioni = @(x) [-sin(x(1))+cos(x(1))-(2/sqrt(2));
                     cos(x(1))+sin(x(1));
                     0]

    % Guess iniziale per le variabili q1, q2, q3
    x0 = [0; 0; 0];

    % Risoluzione del sistema di equazioni
    options = optimoptions('fsolve','Display','iter');
    sol = fsolve(funzioni, x0, options);

    % Stampa dei valori dei risultati in un vettore colonna
    soluzione = sol';
end

function soluzione = risolvi_sistema()
    % Definizione delle equazioni
    funzioni = @(x) [(cos(x(2)))+(sin(x(2))*sin(x(3)))+(sin(x(2))*cos(x(3)))-(sqrt(2));
                     (sin(x(1))*sin(x(2)))+(cos(x(1))*cos(x(3)))-(sin(x(1))*cos(x(2))*sin(x(3)))-(cos(x(1))*sin(x(3)))-(sin(x(1))*cos(x(2))*cos(x(3)));
                     (-cos(x(1))*sin(x(2)))+(sin(x(1))*cos(x(3)))+(cos(x(1))*cos(x(2))*sin(x(3)))+(cos(x(1))*cos(x(2))*cos(x(3)))-(sin(x(1))*sin(x(3)))+1]

    % Guess iniziale per le variabili q1, q2, q3
    x0 = [0; 0; 0];

    % Risoluzione del sistema di equazioni
    options = optimoptions('fsolve','Display','iter');
    sol = fsolve(funzioni, x0, options);

    % Stampa dei valori dei risultati in un vettore colonna
    soluzione = sol';
end
