clear all
clc
%codice del prof
% data
joint_range=700 %[deg] % range of the flange rotation
nr=30 % reduction ratio
res_joint=0.02 %[deg] % desired resolution at the flange side
sectors_motor = 700
% computation
disp("all angles are in degrees")
turns_joint=joint_range/360
turns_motor=nr*turns_joint
bits_turn=ceil(log2(turns_motor))
sectors_joint=360/res_joint
tracks_motor=sectors_joint/nr
res_motor= sectors_motor/360
bits_res=ceil(log2(sectors_motor))
bits=bits_turn+bits_res
% end

