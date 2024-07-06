clear all
clc

syms q1 q2 q3 l2 l3

% Definizione delle equazioni
J = [(sin(q1)*l2*cos(q2) - sin(q1)*l3*cos(q3))    -l2*cos(q1)*sin(q2)   -l3*cos(q1)*sin(q3)
     (cos(q1)*l2*cos(q2) - cos(q1)*l3*cos(q3))    -l2*sin(q1)*sin(q2)   -l3*sin(q1)*sin(q3)
                         0                             l2*cos(q2)            l3*cos(q3)]
angles = [0 , pi, pi/2, -pi/2]

for alpha = angles
    for beta = angles
        for gamma = angles
            rank_J = rank(subs(J,[q2,q3],[beta,gamma]));
            if rank_J < 2
                disp("angoli trovati:")
                disp("q2: "+beta)
                disp("q3: "+gamma)
                disp(" ")
            end
        end
    end
end

J_subs = subs(J,[q2,q3],[pi/2,pi/2])
NULL_J = null(J_subs)
NULL_J_t = null(J_subs.')
RANGE_J = colspace(J_subs)
RANGE_J_t = colspace(J_subs.')
