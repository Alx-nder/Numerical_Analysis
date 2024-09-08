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
dt2 = 0.1; % Second time step
t2 = 0:dt2:t_max; % Time vector for second time step
Nt2 = size(t2,2); % Number of time steps for second time step
f2(1) = 1; % Initial condition for second time step
for i = 1:Nt2-1
    f2(i+1)= f2(i)-dt2*(t2(i)*exp(-t2(i)));
end
plot(t2, f2, 'b--', 'LineWidth', 2); % Numerical solution with second time step
dt3 = 0.05; % Third time step
t3 = 0:dt3:t_max; % Time vector for third time step
Nt3 = size(t3,2); % Number of time steps for third time step
f3(1) = 1; % Initial condition for third time step
for i = 1:Nt3-1
    f3(i+1)= f3(i)-dt3*(t3(i)*exp(-t3(i)));
end
plot(t3, f3, 'g:', 'LineWidth', 2); % Numerical solution with third time step
hold off;
xlabel('Time');legend('Analytical Solution','Numerical Solution (dt=0.2)', 'Numerical Solution (dt=0.1)', 'Numerical Solution (dt=0.05)');
legend('Analytical Solution','Numerical Solution (dt=0.2)', 'Numerical Solution (dt=0.1)', 'Numerical Solution (dt=0.05)');
title('Case1: Numerical and Analytical Solutions');
grid on;