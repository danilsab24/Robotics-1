clear all
clc

syms  alpha beta gamma theta

% Matrice di rotazione
Rz1 = [cos(alpha), -sin(alpha), 0;
       sin(alpha), cos(alpha), 0;
       0, 0, 1];
   
Ry = [cos(beta), 0, sin(beta);
      0, 1, 0;
      -sin(beta), 0, cos(beta)];
  
Rz2 = [cos(gamma), -sin(gamma), 0;
       sin(gamma), cos(gamma), 0;
       0, 0, 1];
% ci serve la matrice di rotazione di x perxhè gli elementi 1,3 e 2,3 del
% prodotto tra due matrici di rotazione non deve essere = 0
Rx = [1, 0, 0;
      0, cos(theta), -sin(theta);
      0, sin(theta), cos(theta)];

R_ZYZ = simplify(Rz1*Ry*Rz2, steps=100)

R_c = simplify(Rx*Rz1, steps=100)
R_d = simplify(Rz2*Rx, steps=100)

R_c_subs = eval(subs(R_c, [alpha, beta, gamma, theta], [pi/4,pi/4,pi/4,pi/4]))
R_d_subs = eval(subs(R_d, [alpha, beta, gamma, theta], [pi/4,pi/4,pi/4,pi/4]))

val_pos_c = +sqrt((R_c_subs(1,3))^2+(R_c_subs(2,3))^2);
val_neg_c = -sqrt((R_c_subs(1,3))^2+(R_c_subs(2,3))^2);

beta_Rc_pos = atan2(val_pos_c,R_c_subs(3,3));
gamma_Rc_pos = atan2(R_c_subs(1,3)/sin(beta_Rc_pos), R_c_subs(2,3)/sin(beta_Rc_pos));
alpha_Rc_pos = atan2(R_c_subs(3,1)/sin(beta_Rc_pos), -R_c_subs(3,2)/sin(beta_Rc_pos));
arr_alpha_c_I = [alpha_Rc_pos;beta_Rc_pos;gamma_Rc_pos];

beta_Rc_neg = atan2(val_neg_c,R_c_subs(3,3)); 
gamma_Rc_neg = atan2(R_c_subs(1,3)/sin(beta_Rc_neg), R_c_subs(2,3)/sin(beta_Rc_neg));
alpha_Rc_neg = atan2(R_c_subs(3,1)/sin(beta_Rc_neg), -R_c_subs(3,2)/sin(beta_Rc_neg));
arr_alpha_c_II = [alpha_Rc_neg;beta_Rc_neg;gamma_Rc_neg];

val_pos_d = sqrt((R_d_subs(1,3))^2+(R_d_subs(2,3))^2);
val_neg_d = -sqrt((R_d_subs(1,3))^2+(R_d_subs(2,3))^2);

beta_Rd_pos = atan2(val_pos_d,R_d_subs(3,3));
gamma_Rd_pos = atan2(R_d_subs(1,3)/sin(beta_Rc_pos), R_d_subs(2,3)/sin(beta_Rc_pos));
alpha_Rd_pos = atan2(R_d_subs(3,1)/sin(beta_Rc_pos), -R_d_subs(3,2)/sin(beta_Rc_pos));
arr_alpha_d_I = [alpha_Rd_pos;beta_Rd_pos;gamma_Rd_pos];

beta_Rd_neg = atan2(val_neg_d,R_d_subs(3,3));
gamma_Rd_neg = atan2(R_d_subs(1,3)/sin(beta_Rd_neg), R_d_subs(2,3)/sin(beta_Rd_neg));
alpha_Rd_neg = atan2(R_d_subs(3,1)/sin(beta_Rd_neg), -R_d_subs(3,2)/sin(beta_Rd_neg));
arr_alpha_d_II = [alpha_Rd_neg;beta_Rd_neg;gamma_Rd_neg];

disp("Angoli della matrice R_C");
disp(" ");
disp("caso I");
disp("alpha: "+alpha_Rc_pos+" beta: "+beta_Rc_pos+" gamma: "+gamma_Rc_pos);
disp("caso II");
disp("alpha: "+alpha_Rc_neg+" beta: "+beta_Rc_neg+" gamma: "+gamma_Rc_neg);
disp(" ");
disp("Angoli della matrice R_D");
disp(" ");
disp("caso I");
disp("alpha: "+alpha_Rd_pos+" beta: "+beta_Rd_pos+" gamma: "+gamma_Rd_pos);
disp("caso II");
disp("alpha: "+alpha_Rd_neg+" beta: "+beta_Rd_neg+" gamma: "+gamma_Rd_neg);

R_C_D = simplify(R_c.'*R_d, steps=100)
R_C_D_subs = eval(subs(R_C_D,[alpha,beta,gamma,theta],[pi/4,pi/4,pi/4,pi/4]))

val_pos_cd = +sqrt((R_C_D_subs(1,3))^2+(R_C_D_subs(2,3))^2);
val_neg_cd = -sqrt((R_C_D_subs(1,3))^2+(R_C_D_subs(2,3))^2);

beta_Rcd_pos = atan2(val_pos_cd,R_C_D_subs(3,3));
gamma_Rcd_pos = atan2(R_C_D_subs(1,3)/sin(beta_Rcd_pos), R_C_D_subs(2,3)/sin(beta_Rcd_pos));
alpha_Rcd_pos = atan2(R_C_D_subs(3,1)/sin(beta_Rcd_pos), -R_C_D_subs(3,2)/sin(beta_Rcd_pos));

beta_Rcd_neg = atan2(val_neg_cd,R_C_D_subs(3,3)); 
gamma_Rcd_neg = atan2(R_C_D_subs(1,3)/sin(beta_Rcd_neg), R_C_D_subs(2,3)/sin(beta_Rcd_neg));
alpha_Rcd_neg = atan2(R_C_D_subs(3,1)/sin(beta_Rcd_neg), -R_C_D_subs(3,2)/sin(beta_Rcd_neg));

disp("Angoli della matrice R_C_D");
disp(" ");
disp("caso I");
disp("alpha: "+alpha_Rcd_pos+" beta: "+beta_Rcd_pos+" gamma: "+gamma_Rcd_pos);
disp("caso II");
disp("alpha: "+alpha_Rcd_neg+" beta: "+beta_Rcd_neg+" gamma: "+gamma_Rcd_neg);

disp(" ");

disp("errori non combaciano con gli angoli di R_C_D: ")
e_alpha_I = arr_alpha_d_I - arr_alpha_c_I
e_alpha_II = arr_alpha_d_I - arr_alpha_c_II
e_alpha_III = arr_alpha_d_II - arr_alpha_c_I
e_alpha_VI = arr_alpha_d_II - arr_alpha_c_I


