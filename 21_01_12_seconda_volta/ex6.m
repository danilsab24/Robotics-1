clear all
clc

syms q1 q2 q3 q4 a b

p = [a*cos(q1) + q3*cos(q1+q2) + b*cos(q1+q2+q4);
     a*sin(q1) + q3*sin(q1+q2) + b*sin(q1+q2+q4);
                 q1+q2+q4]

J = simplify(jacobian(p, [q1,q2,q3,q4]),steps=100)

%det_J = simplify(det(J*J.'),steps=1000)

angles = [0,pi,pi/2,-pi/2]

for alpha = angles
    for beta = angles 
        J_subs = simplify(subs(J, [q2,q3], [alpha,beta]),steps=100);
        rank_J = rank(J_subs);
        if rank_J < 3 
            disp("angoli trovati: ")
            disp("q2 : "+alpha)
            disp("q3 : "+beta)
            disp(" ")
        end
    end
end

J_subs = simplify(subs(J,[q1,q2,q3,q4],[0,pi/2,0,0]),steps=100)

NULL_SPACE_J_subs = null(J_subs)
RANGE_SPACE_J_subs = colspace(J_subs)