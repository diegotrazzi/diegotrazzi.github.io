---
layout: post
title: Self Driving -04- Vehicle Dynamic Modeling
date: 2025-04-07 17:49 -0700
categories: [Self-driving]
tags: [Python, Self-driving, Ai, Machine Learning, Carla]
author: Diego Trazzi
---

## [__Module 4__: Vehicle Dynamic Modeling]((https://www.coursera.org/specializations/self-driving-cars))

#### Lesson 3: The Kinematic Bicycle Model

The model accepts velocity ($v$) and steering rate ($\dot{\delta}$) inputs and steps through the bicycle kinematic equations:

$$  
\begin{align*}
\dot{x}_c &= v \cos{(\theta + \beta)} \\
\dot{y}_c &= v \sin{(\theta + \beta)} \\
\dot{\theta} &= \frac{v \cos{\beta} \tan{\delta}}{L} \\
\dot{\delta} &= \omega \\
\beta &= \tan^{-1}(\frac{l_r \tan{\delta}}{L})
\end{align*}
$$
  
Output:  
  * $(x_f, y_f)$: The coordinates of the front axle center in a global reference frame.
  * $\theta$ (teta): The orientation (heading angle) of the vehicle relative to a reference axis.

Inputs:  
  * $v$	: The velocity of the vehicle.
  * $\dot{\delta}$ (delta): The steering angle of the front wheel.
  * $L$ The wheelbase, i.e., the distance between the front and rear axles.
  * $\beta$  (beta): slip angle at the center of mass of the bicycle. Where $l_r$ is the distance between the rear axel and the center of mass.
  * $\omega$ (omega): how fast you are turning the steering whee. By integrating  over time, you update the steering angle in your simulation: $\delta_1 = \delta_0 + \omega \cdot \Delta t$.

---

#### Lesson 4: Longitudinal Vehicle Modeling

> This model captures how throttle input translates into forward motion while accounting for resistive forces and drivetrain dynamics!

<div style="text-align: center;">
  <img src="data/Module 04 - Vehicle Longitudinal Control/longitudinal-vehicle-model.png" height="300">
</div>

The dynamic equations consist of many stages to convert throttle inputs to wheel speed (engine -> torque converter -> transmission -> wheel). These stages are bundled together in a single inertia term $J_e$ which is used in the following combined engine dynamic equations.

$$
\begin{align}
    J_e \dot{\omega}_e &= T_e - (GR)(r_{eff} F_{load}) \\ m\ddot{x} &= F_x - F_{load}
\end{align}
$$

Where $T_e$ is the engine torque, $GR$ is the gear ratio, $r_{eff}$ is the effective radius, $m$ is the vehicle mass, $x$ is the vehicle position, $F_x$ is the tire force, and $F_{load}$ is the total load force. 

The engine torque is computed from the throttle input and the engine angular velocity $\omega_e$ using a simplified quadratic model. 

$$
\begin{align}
    T_e = x_{\theta}(a_0 + a_1 \omega_e + a_2 \omega_e^2)
\end{align}
$$

The load forces consist of aerodynamic drag $F_{aero}$, rolling friction $R_x$, and gravitational force $F_g$ from an incline at angle $\alpha$. The aerodynamic drag is a quadratic model and the friction is a linear model.

$$
\begin{align}
    F_{load} &= F_{aero} + R_x + F_g \\
    F_{aero} &= \frac{1}{2} C_a \rho A \dot{x}^2 = c_a \dot{x}^2\\
    R_x &= N(\hat{c}_{r,0} + \hat{c}_{r,1}|\dot{x}| + \hat{c}_{r,2}\dot{x}^2) \approx c_{r,1} \dot{x}\\
    F_g &= mg\sin{\alpha}
\end{align}
$$

Note that the absolute value is ignored for friction since the model is used for only forward motion ($\dot{x} \ge 0$). 
 
The tire force is computed using the engine speed and wheel slip equations.

$$
\begin{align}
    \omega_w &= (GR)\omega_e \\
    s &= \frac{\omega_w r_e - \dot{x}}{\dot{x}}\\
    F_x &= \left\{\begin{array}{lr}
        cs, &  |s| < 1\\
        F_{max}, & \text{otherwise}
        \end{array}\right\} 
\end{align}
$$

Where $\omega_w$ is the wheel angular velocity and $s$ is the slip ratio. 

We setup the longitudinal model inside a Python class below. The vehicle begins with an initial velocity of 5 m/s and engine speed of 100 rad/s. All the relevant parameters are defined and like the bicycle model, a sampling time of 10ms is used for numerical integration.

---

###### REFERENCES
* ...