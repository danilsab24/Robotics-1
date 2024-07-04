clear all
clc

syms a b q1 q2 q3 q4

r = [a*cos(q1) + q3*cos(q1+q2) + b*cos(q1+q2+q4);
     a*sin(q1) + q3*sin(q1+q2) + b*sin(q1+q2+q4);
     q1 + q2 + q4]

J = jacobian(r, [q1, q2, q3, q4])

%codice che serve per vedeer i valori degli angoli in cui diminuisce il
%rango

% % Mappa dei valori degli angoli
% angle_map = containers.Map('KeyType','double','ValueType','char');
% angle_map(0) = '0';
% angle_map(pi) = 'pi';
% angle_map(-pi) = '-pi';
% angle_map(pi/2) = 'pi/2';
% angle_map(-pi/2) = '-pi/2';
% 
% 
% % Mappa dei valori degli angoli
% angle_map = containers.Map('KeyType','double','ValueType','char');
% angle_map(0) = '0';
% angle_map(pi) = 'pi';
% angle_map(-pi) = '-pi';
% angle_map(pi/2) = 'pi/2';
% angle_map(-pi/2) = '-pi/2';
% 
% angles = [0, pi, -pi, -pi/2, pi/2];
% 
% configurations = {}; % Inizializza una cella per contenere tutte le configurazioni degli angoli
% 
% for alpha = angles 
%     for beta = angles 
%         for gamma = angles
%             for omega = angles
%                 J_subs = subs(J, [q1, q2, q4, q3], [alpha, beta, gamma, omega]);
%                 rank_J_subs = rank(J_subs);
%                 if rank_J_subs < 3
%                     configuration = {angle_map(alpha), angle_map(beta), angle_map(omega), angle_map(gamma)}; % Crea una configurazione di angoli
%                     configurations{end+1} = configuration; % Aggiungi la configurazione alla cella
%                 end
%             end
%         end
%     end
% end
% 
% if isempty(configurations)
%     disp('Nessuna configurazione trovata che riduca il rango della matrice.');
% else
%     disp('Configurazioni degli angoli che riducono il rango della matrice:');
%     for i = 1:numel(configurations)
%         disp(['Configurazione ', num2str(i), ': ', strjoin(configurations{i}, ', ')]);
%     end
% end

J_subs_final = simplify(subs(J, [q2,q3], [pi/2,0]), steps=100)
range_J = simplify(colspace(J_subs_final), steps=100)
null_spce_J = simplify(null(J_subs_final), steps=100)