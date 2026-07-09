clear 
close all
clc

% Load data
data = load('data.txt');
data = zscore(data);
y1 = data(:, 1); % size
y = data(:, 2); % price

% Matrix A for the linear fit
A = [y1, ones(size(y1))];

% Parameter c
c = (A' * A)^(-1) * (A' * y)

% Predicted prices
predicted_y = A * c;

% Plot the data only
figure;
scatter(y1, y, 'b', 'filled');
grid;
xlabel('Apartment size');
ylabel('Price');
title('Data plot');

% Plot data and line
figure;
scatter(y1, y, 'b','filled');
hold on;
plot(y1, predicted_y, 'r', 'LineWidth', 2);
xlabel('Apartment size');
ylabel('Price');
grid;
title('Least squares predictor');
residuals = y - predicted_y; % (residual) ei = observed value - predicted value
for i = 1:length(y)
    plot([y1(i), y1(i)], [y(i), predicted_y(i)]); % to plot the distance between the point and the line
end
hold off;
