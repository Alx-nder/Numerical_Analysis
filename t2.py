import numpy as np
import matplotlib.pyplot as plt

# Parameters
L = 1.0  # Inductance
R = 0.0110  # Resistance
C = 1.0  # Capacitance
E = lambda t: 1.0  # External voltage source (constant for simplicity)
dt = 0.01  # Time step
t_max = 10  # Maximum time

# Lorentz force parameters
q_charge = 1.0  # Charge of the object (Coulombs)
mass = 10.0  # Mass of the object (kg)
v0 = np.array([2.0, 0.0, 0.0])  # Initial velocity (m/s)
B = np.array([0.0, 0.0, 3.0])  # Magnetic field (T)
E_field = np.array([0.0, 4.0, 0.0])  # Electric field (N/C)

# Initial conditions
q0 = 0.0
i0 = 0.0
position0 = np.array([0.0, 0.0, 0.0])  # Initial position

# Time array
t = np.arange(0, t_max, dt)

# Arrays to store solutions
q = np.zeros_like(t)
i = np.zeros_like(t)
position = np.zeros((len(t), 3))
velocity = np.zeros((len(t), 3))

# Initial values
q[0] = q0
i[0] = i0
position[0] = position0
velocity[0] = v0

# RK4 method
for n in range(len(t) - 1):
    # k1
    k1_q = dt * i[n]
    k1_i = dt * (E(t[n]) - R * i[n] - q[n] / C) / L
    
    # k2
    k2_q = dt * (i[n] + 0.5 * k1_i)
    k2_i = dt * (E(t[n] + 0.5 * dt) - R * (i[n] + 0.5 * k1_i) - (q[n] + 0.5 * k1_q) / C) / L
    
    # k3
    k3_q = dt * (i[n] + 0.5 * k2_i)
    k3_i = dt * (E(t[n] + 0.5 * dt) - R * (i[n] + 0.5 * k2_i) - (q[n] + 0.5 * k2_q) / C) / L
    
    # k4
    k4_q = dt * (i[n] + k3_i)
    k4_i = dt * (E(t[n] + dt) - R * (i[n] + k3_i) - (q[n] + k3_q) / C) / L
    
    # Update q and i
    q[n+1] = q[n] + (k1_q + 2*k2_q + 2*k3_q + k4_q) / 6
    i[n+1] = i[n] + (k1_i + 2*k2_i + 2*k3_i + k4_i) / 6
    
    # Lorentz force
    lorentz_force = q_charge * (E_field + np.cross(velocity[n], B))
    
    # Update velocity and position using Newton's second law
    acceleration = lorentz_force / mass
    velocity[n+1] = velocity[n] + acceleration * dt
    position[n+1] = position[n] + velocity[n] * dt

# Plot results
plt.figure(figsize=(12, 6))

plt.subplot(2, 1, 1)
plt.plot(t, q, label='Charge (q)')
plt.plot(t, i, label='Current (i)')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.legend()

plt.subplot(2, 1, 2)
plt.plot(t, position[:, 0], label='Position x')
plt.plot(t, position[:, 1], label='Position y')
plt.plot(t, position[:, 2], label='Position z')
plt.xlabel('Time (s)')
plt.ylabel('Position (m)')
plt.legend()

plt.tight_layout()
plt.show()
