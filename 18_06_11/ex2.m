clear all
clc

%dati
V_max_I = 0.5;
A_max_I = 0.8;
V_max_II = 0.8;
A_max_II = 0.5;
q_0 = [1;-0.5];
q_fin = [0;0.2];

delta_q = q_fin-q_0
delta_q_I = abs(delta_q(1:1, 1:1))
delta_q_II = abs(delta_q(2:2, 1:1))

%controllo
contr1 = false ;
val_I = (V_max_I^2)/A_max_I 
if delta_q_I>val_I
    contr1 = true;
end
contr2 = false;
val_II = (V_max_II^2)/A_max_II 
if delta_q_I>val_II
    contr2 = true;
end
disp("controllo joint 1: "+contr1);
disp("controllo joint 2: "+contr2);

%per il joint 1 -> BANG-COST-BANG
T_I = (delta_q_I*A_max_I+(V_max_I)^2)/(A_max_I*V_max_I)
disp("tempo minimo per il joint 1: "+T_I)

%per il joint 1 -> BANG-BANG
T_II = sqrt((4*delta_q_II)/(A_max_II));
disp("Tempo minimo per il joint 2: "+T_II)
