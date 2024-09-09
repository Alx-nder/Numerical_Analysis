import numpy as np
import matplotlib.pyplot as plt

# Parameters
L = lambda x: x*0.00007  # Inductance
R = lambda x: x*0.005  # Resistance
C = 5.0  # Capacitance
E = lambda t: 100000.0  # External voltage source (constant for simplicity)
dt = 0.01  # Time step
t_max = 10  # Maximum time

# Initial conditions
q0 = 100000*5
i0 = 0.0

# Time array
t = np.arange(0, t_max, dt)

# Arrays to store solutions
q = np.zeros(len(t))
i = np.zeros(len(t))
position = np.zeros(len(t))
velocity = np.zeros(len(t))

# Lorentz force parameters
mass = 10.0  # Mass of the object (kg)
v0 = 0.0 # Initial velocity (m/s)


# Initial values
q[0] = q0
i[0] = i0
velocity[0] = v0
position0 = 0.0  # Initial position
position[0] = position0


# RK4 method
for n in range(len(t) - 1):
    # k1
    k1_q = dt * i[n]
    k1_i = dt * (E(t[n]) - R(position[n]) * i[n] - q[n] / C) / L(position[n])
    
    # k2
    k2_q = dt * (i[n] + 0.5 * k1_i)
    k2_i = dt * (E(t[n] + 0.5 * dt) - R(position[n]) * (i[n] + 0.5 * k1_i) - (q[n] + 0.5 * k1_q) / C) / L(position[n])
    
    # k3
    k3_q = dt * (i[n] + 0.5 * k2_i)
    k3_i = dt * (E(t[n] + 0.5 * dt) - R(position[n]) * (i[n] + 0.5 * k2_i) - (q[n] + 0.5 * k2_q) / C) / L(position[n])
    
    # k4
    k4_q = dt * (i[n] + k3_i)
    k4_i = dt * (E(t[n] + dt) - R(position[n]) * (i[n] + k3_i) - (q[n] + k3_q) / C) / L(position[n])
    
    # Update q and i
    q[n+1] = q[n] + (k1_q + 2*k2_q + 2*k3_q + k4_q) / 6
    i[n+1] = i[n] + (k1_i + 2*k2_i + 2*k3_i + k4_i) / 6
    
    # Lorentz force
    lorentz_force = (i[n]**2) * 0.5*L(position[n]) 
    
    # Update velocity and position using Newton's second law
    acceleration = lorentz_force / mass
    velocity[n+1] = velocity[n] + acceleration * dt
    position[n+1] = position[n] + velocity[n] * dt



# Plot results
plt.plot(t, q, label='Charge (q)')
plt.plot(t, i, label='Current (i)')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.legend()
plt.show()
