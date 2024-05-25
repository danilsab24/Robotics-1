
% non funziona

% % Parametri dati
% Im = 1.5e-4;  % Inerzia del rotore del motore DC [kgm^2]
% N = 2000;     % Numero di impulsi per giro del codificatore incrementale
% nr1 = 10;     % Rapporto di riduzione del primo ingranaggio
% It = 0.5e-2;  % Inerzia dell'albero di trasmissione [kgm^2]
% Il = 0.8e-1;  % Inerzia del carico [kgm^2]
% accelerazione = 2;  % Accelerazione del carico [rad/s^2]
% 
% % Funzione per calcolare l'inertza riflessa dato nr2
% reflected_inertia = @(nr2) Im + It/nr1^2 + Il/(nr1*nr2)^2;
% 
% % Trova il valore ottimale di nr2 che minimizza l'inertza riflessa
% options = optimset('Display', 'off');
% nr2_optimal = fminbnd(@(nr2) reflected_inertia(nr2), 1, 1000, options);
% 
% % Calcola l'inertza riflessa utilizzando il valore ottimale di nr2
% I_reflected = reflected_inertia(nr2_optimal);
% 
% % Calcola il momento torcente necessario
% tau_m = I_reflected * acceleration;
% 
% disp(['Valore ottimale di nr2: ', num2str(nr2_optimal)]);
% disp(['Il momento torcente necessario per accelerare il carico è: ', num2str(tau_m), ' Nm']);
