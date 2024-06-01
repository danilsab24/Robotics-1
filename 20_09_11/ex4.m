clear all
clc

syms q1 q2 q3 L1 L2 L3

J = [-sin(q1)*(L2*cos(q2)+L3*cos(q3))    -L2*cos(q1)*sin(q2)   -L3*cos(q1)*sin(q3);
      cos(q1)*(L2*cos(q2)+L3*cos(q3))    -L2*sin(q1)*sin(q2)   -L3*sin(q1)*sin(q3);
                   0                           L2*cos(q2)           L3*cos(q3)]
det_J = simplify(det(J), steps=100)
angles = [0,pi,pi/2,-pi/2]
find_angle = false;
% codici che non servono
% disp(" ")
% disp("controllo rango < 3")
% for alpha=angles
%     J_subs = subs(J, q1, alpha);
%     rank_J = rank(J_subs);
%     if rank_J < 3 
%         find_angle = true;
%         disp("valore q1:"+alpha)
%     end
% end
% for alpha=angles
%     J_subs = subs(J, q2, alpha);
%     rank_J = rank(J_subs);
%     if rank_J < 3
%         find_angle = true;
%         disp("valore q2:"+alpha)
%     end
% end
% for alpha=angles
%     J_subs = subs(J, q3, alpha);
%     rank_J = rank(J_subs);
%     if rank_J < 3 
%         find_angle = true;
%         disp("valore q3:"+alpha)
%     end
% end
disp(" ")
disp("controllo rango < 3 e rango < 2")
if find_angle == false
    for alpha=angles
        for beta = angles
            J_subs = subs(J, [q1,q2], [alpha,beta]);
            rank_J = rank(J_subs);
            if rank_J < 3 
                find_angle = true;
                disp(" ")
                disp("valore q1:"+alpha)
                disp("valore q2:"+beta)
            end
        end 
    end
end
for alpha=angles
    for beta = angles
        J_subs = subs(J, [q1,q3], [alpha,beta]);
        rank_J = rank(J_subs);
        if rank_J < 3 
            find_angle = true;
            disp(" ")
            disp("valore q1:"+alpha)
            disp("valore q3:"+beta)
        end
        if rank_J < 2 
            find_angle = true;
            disp(" RANGO < 2")
            disp(" ")
            disp("valore q1:"+alpha)
            disp("valore q3:"+beta)
        end
    end 
end
if find_angle == false
    for alpha=angles
        for beta = angles
            J_subs = subs(J, [q2,q3], [alpha,beta]);
            rank_J = rank(J_subs);
            if rank_J < 3 
                find_angle = true;
                disp(" ")
                disp("valore q2:"+alpha)
                disp("valore q3:"+beta)
            end
            if rank_J < 2 
                find_angle = true;
                disp(" RANGO < 2")
                disp(" ")
                disp("valore q2:"+alpha)
                disp("valore q3:"+beta)
            end
        end 
    end
end
disp(" ")
disp("controllo rango < 2")
for alpha=angles
    for beta = angles
        for gamma = angles
            J_subs = subs(J, [q1,q2,q3], [alpha,beta,gamma]);
            rank_J = rank(J_subs);
            if rank_J < 2 
                find_angle = true;
                disp(" ")
                disp("valore q1:"+alpha)
                disp("valore q2:"+beta)
                disp("valore q3:"+gamma)
            end
        end
    end 
end

J_subs = subs(J, [q2,q3], [pi/2,pi/2])
J_subs_T = J_subs.';
NULL_SPACE = null(J_subs)
NULL_SPACE_T = null(J_subs_T)
RANGE_SPACE = colspace(J_subs)
RANGE_SPACE_T = colspace(J_subs_T)