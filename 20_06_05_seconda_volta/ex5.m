clear all
clc
%domanda c
disp("Domanda C")
% Given parameters
Tc = 0.03;
omega = 2;
k = 20;

% Time vector
t = (0:Tc:0.6)';

% Joint position profile
q = -3 * cos(omega * t);

% Exact velocity at k=20
exact_velocity = 6 * sin(omega * t(k+1));

% 1-step backward difference formula
velocity_1step = (q(k+1) - q(k)) / Tc;

% 4-step backward difference formula
velocity_4step = (25*q(k+1) - 48*q(k) + 36*q(k-1) - 16*q(k-2) + 3*q(k-3)) / (12 * Tc);

% Percentage errors
error_1step = abs((velocity_1step - exact_velocity) / exact_velocity) * 100;
error_4step = abs((velocity_4step - exact_velocity) / exact_velocity) * 100;

% Display results
fprintf('Exact velocity: %.6f rad/s\n', exact_velocity);
fprintf('1-step BDF velocity: %.6f rad/s\n', velocity_1step);
fprintf('4-step BDF velocity: %.6f rad/s\n', velocity_4step);
fprintf('1-step BDF error: %.2f%%\n', error_1step);
fprintf('4-step BDF error: %.2f%%\n', error_4step);
disp(" ")
disp("Domanda A")

% Example usage:
R1 = [1/sqrt(2),  0, 1/sqrt(2); 
      0,          1,  0; 
      -1/sqrt(2), 0, -1/sqrt(2)];
R2 = [-1/sqrt(3)  -1/sqrt(2)   -1/sqrt(6);
      -1/sqrt(3)     0          2/sqrt(6);
      -1/sqrt(3)     1/sqrt(2)  -1/sqrt(6)];
R3 = [-sqrt(0.5)   1/sqrt(2)   0;
      sqrt(0.5)    1/sqrt(2)   0;
          0           0       -1];

disp('Checking R1:');
checkRotationMatrix(R1);

disp('Checking R2:');
checkRotationMatrix(R2);

disp('Checking R3:');
checkRotationMatrix(R3);

function isRotationMatrix = checkRotationMatrix(R)
    % Check if the matrix is square
    [rows, cols] = size(R);
    if rows ~= cols
        isRotationMatrix = false;
        disp('The matrix is not square.');
        return;
    end
    
    % Check if the determinant is 1
    detR = det(R);
    if abs(detR - 1) > 1e-6
        isRotationMatrix = false;
        disp('The determinant of the matrix is not 1.');
        return;
    end
    
    % Check if the matrix is orthogonal: R' * R should be the identity matrix
    identityMatrix = eye(rows);
    if norm(R' * R - identityMatrix) > 1e-6
        isRotationMatrix = false;
        disp('The matrix is not orthogonal.');
        return;
    end
    
    % If all checks are passed, the matrix is a rotation matrix
    isRotationMatrix = true;
    disp('The matrix is a valid rotation matrix.');
end


