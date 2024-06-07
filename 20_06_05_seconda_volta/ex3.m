clear all
clc

syms q1 q2 q3

J = [-sin(q1)*(cos(q2+cos(q2+q3)))  -cos(q1)*(sin(q2)+sin(q2+q3))  -cos(q1)*sin(q2+q3);
     cos(q1)*(cos(q2)+cos(q2+q3))   -sin(q1)*(sin(q2)+sin(q2+q3))  -sin(q1)*sin(q2+q3);
               0                        cos(q2)+cos(q2+q3)              cos(q2+q3)]
det_J = simplify(det(J), steps=100)


angles = [0,pi,pi/2,-pi/2];
find = false;
for alpha = angles
    J_subs = subs(J,q1,alpha);
    rank_J_subs = rank(J_subs);
    if rank_J_subs < 3 
        find = true;
        disp("angoli trovati rango 2 ");
        disp("q1: "+ alpha)
    end
    if rank_J_subs < 2 
        find = true;
        disp("angoli trovati rango 1 ");
        disp("q1: "+ alpha)
    end
end

if find == false 
    for alpha = angles
        J_subs = subs(J,q2,alpha);
        rank_J_subs = rank(J_subs);
        if rank_J_subs < 3 
            find = true;
            disp("angoli trovati rango 2 ");
            disp("q2: "+ alpha)
        end
        if rank_J_subs < 2 
            find = true;
            disp("angoli trovati rango 1 ");
            disp("q2: "+ alpha)
        end
    end
end
if find == false 
    for alpha = angles
        J_subs = subs(J,q3,alpha);
        rank_J_subs = rank(J_subs);
        if rank_J_subs < 3 
            find = true;
            disp("angoli trovati rango 2 ");
            disp("q3: "+ alpha)
        end
        if rank_J_subs < 2 
            find = true;
            disp("angoli trovati rango 1 ");
            disp("q3: "+ alpha)
        end
    end
end
for alpha = angles
    for beta = angles 
        J_subs = subs(J,[q1,q2],[alpha,beta]);
        rank_J_subs = rank(J_subs);
        if rank_J_subs < 3 
            find = true;
            disp("angoli trovati rango 2 ");
            disp("q1: "+ alpha)
            disp("q2: "+ beta)
        end
        if rank_J_subs < 2 
            find = true;
            disp("angoli trovati rango 1 ");
            disp("q1: "+ alpha)
            disp("q2: "+ beta)
        end
    end
end

if find == false
    for alpha = angles
        for beta = angles 
            J_subs = subs(J,[q1,q3],[alpha,beta]);
            rank_J_subs = rank(J_subs);
            if rank_J_subs < 3 
                find = true;
                disp("angoli trovati rango 2 ");
                disp("q1: "+ alpha)
                disp("q3: "+ beta)
            end
            if rank_J_subs < 2 
                find = true;
                disp("angoli trovati rango 1 ");
                disp("q1: "+ alpha)
                disp("q3: "+ beta)
            end
        end
    end
end

if find == false
    for alpha = angles
        for beta = angles 
            J_subs = subs(J,[q2,q3],[alpha,beta]);
            rank_J_subs = rank(J_subs);
            if rank_J_subs < 3 
                find = true;
                disp("angoli trovati rango 2 ");
                disp("q2: "+ alpha)
                disp("q3: "+ beta)
            end
            if rank_J_subs < 2 
                find = true;
                disp("angoli trovati rango 1 ");
                disp("q2: "+ alpha)
                disp("q3: "+ beta)
            end
        end
    end
end
if find == false
    for alpha = angles 
        for beta = angles 
            for gamma = angles 
                J_subs = subs(J,[q2,q3],[alpha,beta]);
                rank_J_subs = rank(J_subs);
                if rank_J_subs < 3 
                    find = true;
                    disp("angoli trovati rango 2 ");
                    disp("q1: "+ alpha)
                    disp("q2: "+ beta)
                    disp("q3: "+ gamma)
                end
                if rank_J_subs < 2 
                    find = true;
                    disp("angoli trovati rango 1 ");
                    disp("q1: "+ alpha)
                    disp("q2: "+ beta)
                    disp("q3: "+ gamma)
                end
            end
        end
    end
end

J_rank_II = subs(J,[q1,q2,q3],[0,0,0])
NULL_SPACE_J_rank_II = null(J_rank_II)
RANGE_SPACE_J_rank_II = colspace(J_rank_II)

J_rank_I = subs(J,[q1,q2,q3],[0,0,pi])
NULL_SPACE_J_rank_I = null(J_rank_II)
RANGE_SPACE_J_rank_I = colspace(J_rank_II)
