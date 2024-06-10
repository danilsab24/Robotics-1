clear all
clc

% Parametri dati
range_giunto = 700; % in gradi
risoluzione_finale = 0.02; % in gradi
rapporto_riduzione = 30;

% Calcolo del numero di giri del motore necessari per coprire il range del giunto
numero_giri_motore = (range_giunto / 360) * rapporto_riduzione

% Calcolo del numero di passi dell'encoder
numero_passi_encoder = range_giunto / risoluzione_finale

% Calcolo del numero di bit richiesti
numero_bit = ceil(log2(numero_passi_encoder))

