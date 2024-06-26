clear all
clc

syms l1 l2 q1a q2a q1b q2b

p_a = [l1*cos(q1a)+l2*cos(q1a+q2a);
       l1*sin(q1a)+l2*sin(q1a+q2a)]

p_b = [l1*cos(q1b)+l2*cos(q1b+q2b);
       l1*sin(q1b)+l2*sin(q1b+q2b)]

%non serve
% p_a_subs = eval(subs(p_a,[q1a,q2a,l1,l2], [(3/4)*pi,-pi/2,1,1]))
% p_b_subs = eval(subs(p_b,[q1b,q2b,l1,l2], [pi/2,-pi/2,1,1]))

J_a = jacobian(p_a,[q1a,q2a])
J_b = jacobian(p_b,[q1b,q2b])

J_a_subs = eval(subs(J_a,[q1a,q2a,l1,l2], [(3/4)*pi,-pi/2,1,1]))
J_b_subs = eval(subs(J_b,[q1b,q2b,l1,l2], [pi/2,-pi/2,1,1]))

tau_a = J_a_subs.'*[10*cos((3*pi/4)-(pi/2)); 10*sin((3*pi/4)-(pi/2))]
tau_b = J_b_subs.'*[10*cos((3*pi/4)-(pi/2)); 10*cos((3*pi/4)-(pi/2))]