clear all 
clc

syms q1 q2 q3 K D px py

matr = [K+D*cos(q3) -D*sin(q3)-q2;
        D*sin(q3)-q2 K+D*cos(q3)];
eq_fina = simplify(inv(matr)*[px;py],steps=100)

p = [K*cos(q1) + D*cos(q1+q3) - q2*sin(q1);
     K*sin(q1) + D*sin(q1+q3) + q2*cos(q1);
               q1+q3];

p_subs = subs(p,[K,D],[1,sqrt(2)]);

eq1 = p_subs(1)==2;
eq2 = p_subs(2)==1;
eq3 = p_subs(3)==-pi/6;

sol = solve([eq1,eq2,eq3],[q1,q2,q3])
disp("solution")
disp("solutions q1:")
disp(eval(sol.q1))
disp("solutions q2:")
disp(eval(sol.q2))
disp("solutions q3:")
disp(eval(sol.q3))




