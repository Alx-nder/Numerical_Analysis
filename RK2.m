clc; % Clear the command window.
clear; % Erase all existing variables. Or clearvars if you want.
close all; % Close all figures (except those of imtool.)

t_max =2 % Maximun time to be calculated
Dt=0.1   % Numerical Time step
t=0:Dt:t_max; % Time vector
N=size(t,2); % Number of time steps
f_RK2(1)=0; % Initial ODE condition

for i = 1:N-1
    k1_1 = Dt* (2* f_RK2(i)+ 4*t(i));
    k2_1 = Dt*(2* (f_RK2(i)+k1_1/2)+4*(t(i)+Dt/2));
    f_RK2(i+1) = f_RK2(i) + k2_1;
end

% Analytical solution
f_analytical = (-2*t)-1+ 1*exp(2*t);


figure
plot(t, f_analytical, 'black', 'LineWidth', 2); % Analytical solution
hold on;

plot(t, f_RK2, 'ro-', 'MarkerSize', 8,'LineWidth',2); % Numerical solution with nodes at each time step
hold on;

dt2 = 0.1; % Third time step
t2 = 0:dt2:t_max; % Time vector for third time step
Nt2 = size(t2,2); % Number of time steps for third time step
f2(1) = 0; % Initial condition for third time step
for i = 1:Nt2-1
    f2(i+1)= f2(i)+ dt2*(2*f2(i)+ 4*t2(i)); % Euler step to calculate f(i+1)
end
plot(t2, f2, 'g:', 'LineWidth', 2); % Numerical solution with third time step
hold off;


xlabel('Time');
legend('Analytical Solution','Numerical Solution (RK2) dt=0.1','Numerical Solution (Euler) dt=0.1');
title('Stiff ODE Runge Kutta 2: Numerical and Analytical Solutions');
grid on;
