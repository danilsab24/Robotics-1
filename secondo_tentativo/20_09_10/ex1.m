clear all
clc

syms t

R_t = [       cos(t)        0          sin(t);
          (sin(t))^2     cos(t)   -sin(t)*cos(t);
       -sin(t)*cos(t)    sin(t)      cos(t)^2]
R_dot_t = diff(R_t,t)

S_omega = simplify(R_dot_t*R_t.', steps=100)

R_dot_dot_t = simplify(diff(R_dot_t,t),steps=100)

S_omega_dot = simplify(R_dot_dot_t*R_t.' - S_omega*R_dot_t*R_t.', steps=100)