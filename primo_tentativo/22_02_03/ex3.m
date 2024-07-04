clear all
clc

syms q1 q2 q3 L

p = [L*cos(q1)+L*cos(q1+q2)+L*cos(q1+q2+q3);
     L*sin(q1)+L*sin(q1+q2)+L*sin(q1+q2+q3);
               q1+q2+q3]
J = simplify(jacobian(p,[q1,q2,q3]), steps=100)

det_J = simplify(det(J*J.'), steps=100)


%non necessario
% J_L_red = J   % perchè è stato preso da un vecchio esame
% angles = [0, pi, -pi, -pi/2, pi/2]
% find_angles = false
% for alpha = angles 
%     J_L_red_subs = subs(J_L_red, [q1,q2,q3], [alpha,0,0]);
%     rank_J_L_red_subs = rank(J_L_red_subs);
%     if rank_J_L_red_subs < 3 
%         find_angles = true
%         disp("angoli trovati: ");
%         disp("q1: "+alpha)
%     end
% end
% 
% if find_angles == false 
%     for alpha = angles
%         for beta = angles
%             J_L_red_subs = subs(J_L_red, [q1,q2,q3], [0,alpha, beta]);
%             rank_J_L_red_subs = rank(J_L_red_subs);
%             if rank_J_L_red_subs < 3 
%                 find_angles = true
%                 disp("angoli trovati: ");
%                 disp("q2: "+alpha);
%                 disp("q3: "+beta);
%             end
%         end
%     end
% end
% if find_angles == false 
%     for alpha = angles
%         for beta = angles
%             for gamma = angles
%                 J_L_red_subs = subs(J_L_red, [q1,q2, q3], [alpha, beta, gamma]);
%                 rank_J_L_red_subs = rank(J_L_red_subs);
%                 if rank_J_L_red_subs < 3 
%                     find_angles = true
%                     disp("angoli trovati: ");
%                     disp("q1: "+alpha);
%                     disp("q2: "+beta);
%                     disp("q3: "+gamma);
%                 end
%             end
%         end
%     end
% end
% if find_angles == false 
%     disp("angoli non trovati");
% end