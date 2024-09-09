clc; % Clear the command window.
clear; % Erase all existing variables. Or clearvars if you want.
close all; % Close all figures (except those of imtool.)



t_max = 2; % Maximum time to simulate
Dt=0.02; % Numerical Time step
t=0:Dt:t_max;   % Time vector
N=size(t,2); % Number of time steps
f(1) = 0; % Initial condition f(1) <==> t=0
for i = 1:N-1
    f(i+1)= f(i)+ Dt*(2*f(i)+ 4*t(i)); % Euler step to calculate f(i+1)
end

% Analytical solution
f_analytical = (-2*t)-1+ 1*exp(2*t);

% Plotting

plot(t, f_analytical, 'black', 'LineWidth', 2); % Analytical solution
hold on;
plot(t, f, 'ro-', 'MarkerSize', 8,'LineWidth',2); % Numerical solution with nodes at each time step

dt2 = 0.05; % Second time step
t2 = 0:dt2:t_max; % Time vector for second time step
Nt2 = size(t2,2); % Number of time steps for second time step
f2(1) = 0; % Initial condition for second time step
for i = 1:Nt2-1
    f2(i+1)= f2(i)+ dt2*(2*f2(i)+ 4*t2(i)); % Euler step to calculate f(i+1)
end
plot(t2, f2, 'b--', 'LineWidth', 2); % Numerical solution with second time step

dt3 = 0.1; % Third time step
t3 = 0:dt3:t_max; % Time vector for third time step
Nt3 = size(t3,2); % Number of time steps for third time step
f3(1) = 0; % Initial condition for third time step
for i = 1:Nt3-1
    f3(i+1)= f3(i)+ dt3*(2*f3(i)+ 4*t3(i)); % Euler step to calculate f(i+1)
end
plot(t3, f3, 'g:', 'LineWidth', 2); % Numerical solution with third time step
hold off;
xlabel('Time');legend('Analytical Solution','Numerical Solution (dt=0.2)', 'Numerical Solution (dt=0.1)', 'Numerical Solution (dt=0.05)');
legend('Analytical Solution','Numerical Solution (dt=0.02)', 'Numerical Solution (dt=0.05)', 'Numerical Solution (dt=0.1)');
title('Stiff ODE: Numerical and Analytical Solutions');
grid on;