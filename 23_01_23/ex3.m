clc
clear all

syms theta1 theta2 a b c 

theta2 = 0

a = 1 - 2*sin(theta2)

b = 2*cos(theta2)

c = 2

u_1 = (a + sqrt(a^2 + b^2 - c^2))/(b + c)