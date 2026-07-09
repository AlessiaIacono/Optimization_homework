clear
close all
clc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load data
data = load('data.txt');
% Data standardization
data=zscore(data);

y1_standard = data(:, 1); % size
y_standard = data(:, 2); % price

% Initialize parameters
c = zeros(2, 1); % Initial guess for c1 and c2
alpha = 0.01; % step size
H = 100; % Number of iterations

% Gradient descent
c_values = zeros(2, H); % for each iteration we store parameters
for iter = 1:H
    % predictions
    predicted_y = c(1) * y1_standard + c(2);

    % residuals
    residuals = y_standard - predicted_y;

    % gradients % gradient = -2*A'(y-Ac)
    grad_c = -2 * [y1_standard, ones(size(y1_standard))]' * (y_standard - [y1_standard, ones(size(y1_standard))] * c);
    
    % update 
    c = c - alpha * grad_c;

    % put parameters in the vector 
    c_values(:, iter) = c;
end

% Plot convergence of c as a function of iteration number
figure;
plot(1:H, c_values(1, :), 'b', 'LineWidth', 2);
hold on;
plot(1:H, c_values(2, :), 'r', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Parameter value');
title('Convergence of parameters');
legend('c1', 'c2');
grid on;
hold off;

