clc; clear; close all; 
 
k = 350;        % N/m 
m = 2;          % kg 
g = 9.81;       % m/s^2 
 
% Uncertainties (fixed) 
dk = 0.10 * k;      %  uncertainty in k 
dm = 0.10 * m;      %  uncertainty in m 
dx_mm = 5;          % <-- fixed displacement uncertainty (mm) 
 
n = input('Enter number of trials: '); 
 
x_mm = zeros(1,n); 
mu = zeros(1,n); 
dmu = zeros(1,n); 
 
for i = 1:n 
    fprintf('\n--- Trial %d ---\n', i); 
     
    x_mm(i) = input('Enter displacement (mm): '); 
     
    % Convert to meters 
    x_m = x_mm(i) / 1000; 
     
   
    % FRICTION CALCULATION 
    mu(i) = (k * x_m) / (m * g); 
     
    
    % UNCERTAINTY CALCULATION 
    rel_error = sqrt( (dx_mm/x_mm(i))^2 + (dk/k)^2 + (dm/m)^2 ); 
     
    dmu(i) = mu(i) * rel_error; 
end 
 
% DISPLAY RESULTS 
 
fprintf('\n===== RESULTS =====\n'); 
for i = 1:n 
    fprintf('Trial %d: Friction Coefficient = %.3f ± %.3f\n', i, mu(i), dmu(i)); 
end 
 
fprintf('\nAverage Friction Coefficient: %.3f\n', mean(mu)); 
fprintf('Std deviation: %.3f\n', std(mu)); 
 
 
% Plot 1: mu vs displacement 
figure; 
errorbar(x_mm, mu, dmu, 'o-', 'LineWidth', 2); 
xlabel('Displacement (mm)'); 
ylabel('Friction Coefficient (\mu)'); 
title('\mu vs Displacement (with uncertainty)'); 
grid on; 
 
% Plot 2: mu vs trial 
figure; 
errorbar(1:n, mu, dmu, 's-', 'LineWidth', 2); 
xlabel('Trial Number'); 
ylabel('Friction Coefficient (\mu)'); 
title('Friction Coefficient vs Trial'); 
grid on;
