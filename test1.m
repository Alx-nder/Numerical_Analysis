% df(t)/dt = -t*exp(-t)
% f(0)=1

% Soln
%  f(t) = (t+1)*exp(-t)

clc; % Clear the command window.
clear; % Erase all existing variables. Or clearvars if you want.
close all; % Close all figures (except those of imtool.)

t_max = 5; % Maximum time to simulate
dt = 0.2; % Numerical Time step
t = 0:dt:t_max; % Time vector
Nt = size(t,2); % Number of time steps

f(1) = 1; % Initial condition f(1) <==> t=0
for i = 1:Nt-1
    f(i+1)= f(i)-dt*(t(i)*exp(-t(i)));
end

% Analytical solution
f_analytical = (t+1).*exp(-t);

% Plotting
figure;

plot(t, f_analytical, 'black', 'LineWidth', 2); % Analytical solution
hold on;
plot(t, f, 'ro-', 'MarkerSize', 8,'LineWidth',2); % Numerical solution with nodes at each time step
% plot(t, f, 'r--', 'LineWidth', 2); % Numerical solution
hold off;
xlabel('Time');
ylabel('f(t)');
legend('Analytical Solution','Numerical Solution');
title('Numerical and Analytical Solutions');
grid on;