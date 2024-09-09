clc; % Clear the command window.
clear; % Erase all existing variables. Or clearvars if you want.
close all; % Close all figures (except those of imtool.)

t_max = 2; % Maximum time to simulate
Dt=0.1; % Numerical Time step
t=0:Dt:t_max;   % Time vector
N=size(t,2); % Number of time steps
f_RK4(1) = 0; % Initial condition f(1) 

for i = 1:N-1

    k1= Dt*(2*f_RK4(i)+ 4*t(i));
    k2= Dt*(2*(f_RK4(i)+k1/2)+ 4*(t(i)+Dt/2));
    k3= Dt*(2*(f_RK4(i)+k2/2)+ 4*(t(i)+Dt/2));
    k4= Dt*(2*(f_RK4(i)+k3)+ 4*(t(i)+Dt));

    f_RK4(i+1)= f_RK4(i)+ (k1+2*k2+2*k3+k4)/6; % RK4 step to calculate f(i+1)0
end

% Analytical solution
f_analytical = (-2*t)-1+ 1*exp(2*t);

% Plotting
figure 
plot(t, f_analytical, 'black', 'LineWidth', 2); % Analytical solution
hold on;
plot(t, f_RK4, 'ro--', 'MarkerSize', 4,'LineWidth',1); % Numerical solution with nodes at each time step
hold off;
xlabel('Time');
legend('Analytical Solution','Numerical Solution (RK4) dt=0.1');
title('Stiff ODE Runge Kutta 4: Numerical and Analytical Solutions');
grid on;
