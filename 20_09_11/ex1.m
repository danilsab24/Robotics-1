clear all
clc
% codice errato :(
syms t

R = [cos(t)           0         sin(t);
     sin(t)^2       cos(t)  -sin(t)*cos(t);
     -sin(t)*cos(t) sin(t)      cos(t)^2]
r_11 = R(1,1);
r_12 = R(1,2);
r_13 = R(1,3);
r_21 = R(2,1);
r_22 = R(2,2);
r_23 = R(2,3);
r_31 = R(3,1);
r_32 = R(3,2);
r_33 = R(3,3);
theta = atan2(sqrt((r_13+r_31)^2+(r_12+r_21)^2+(r_23+r_32)^2), r_11+r_22+r_33)
r = (1/2*sin(theta))*[r_32-r_23; r_13-r_31; r_21-r_12]