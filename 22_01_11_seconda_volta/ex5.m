clear all
clc

syms v t a b T

input_char = input('Inserisci "y" o "n" se vuoi i grafici delle traiettorie: ', 's');

if strcmp(input_char, 'y')

    % Definizione dei parametri
    a = 1; % Puoi cambiare questi valori come preferisci
    b = 0.3; % Puoi cambiare questi valori come preferisci
    
    % Definizione del range di s
    s = linspace(0, 1, 1000); % s varia da 0 a 1 con 1000 punti
    
    % Calcolo delle traiettorie
    p_s = [-a*sin(2*pi*s); b*cos(2*pi*s)];
    p_dot_s = -2*pi*[a*cos(2*pi*s); b*sin(2*pi*s)];
    p_dot_dot_s = 4*(pi^2)*[a*sin(2*pi*s); -b*cos(2*pi*s)];
    
    % Plot delle traiettorie
    figure;
    
    % Plot di p_s
    subplot(3, 1, 1);
    plot(s, p_s(1,:), 'r', 'DisplayName', 'x');
    hold on;
    plot(s, p_s(2,:), 'b', 'DisplayName', 'y');
    xlabel('s');
    ylabel('p_s');
    title('Plot of p_s vs s');
    legend;
    grid on;
    
    % Plot di p_dot_s
    subplot(3, 1, 2);
    plot(s, p_dot_s(1,:), 'r', 'DisplayName', 'x');
    hold on;
    plot(s, p_dot_s(2,:), 'b', 'DisplayName', 'y');
    xlabel('s');
    ylabel('p\_dot\_s');
    title('Plot of p\_dot\_s vs s');
    legend;
    grid on;
    
    % Plot di p_dot_dot_s
    subplot(3, 1, 3);
    plot(s, p_dot_dot_s(1,:), 'r', 'DisplayName', 'x');
    hold on;
    plot(s, p_dot_dot_s(2,:), 'b', 'DisplayName', 'y');
    xlabel('s');
    ylabel('p\_dot\_dot\_s');
    title('Plot of p\_dot\_dot\_s vs s');
    legend;
    grid on;
end


p_t = [-a*sin(2*pi*v*t); 
        b*cos(2*pi*v*t)]

p_dot_t = diff(p_t,t)

p_dot_dot_t = diff(p_dot_t,t)

p_dot_t_I = simplify(norm(subs(p_t,t,0)),steps=100)
p_dot_t_II = simplify(norm(subs(p_t,T/2,0)),steps=100)
p_dot_t_III = simplify(norm(subs(p_t,T,0)),steps=100)


