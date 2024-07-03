clear all
clc

% Dati dell'encoder e del riduttore armonico
bits_per_turn = 8
total_bits = 11
turn_bits = total_bits - bits_per_turn
turn_resolution = 2^bits_per_turn
total_turns = 2^turn_bits
flexspline_teeth = 120
circular_spline_teeth = 2
reduction_ratio = flexspline_teeth / circular_spline_teeth

% Calcolo della risoluzione angolare dal lato del link
angular_resolution = 2 * pi / (turn_resolution * reduction_ratio);
fprintf('Risoluzione angolare dal lato del link: %.10f rad\n', angular_resolution);

% Calcolo dello spostamento angolare massimo misurabile dal lato del motore
max_angular_displacement = total_turns * 2 * pi;
fprintf('Spostamento angolare massimo misurabile dal lato del motore: %.2f rad\n', max_angular_displacement);

% Conversione del codice Gray in angolo del motore
gray_code = '01100001';
binary_code = zeros(1, length(gray_code));
binary_code(1) = str2double(gray_code(1));
for i = 2:length(gray_code)
    binary_code(i) = xor(binary_code(i-1), str2double(gray_code(i)));
end
decimal_value = bin2dec(num2str(binary_code));
theta_m = decimal_value / turn_resolution * 2 * pi;
fprintf('Angolo del motore θm per il codice Gray [000|01100001]: %.10f rad\n', theta_m);
