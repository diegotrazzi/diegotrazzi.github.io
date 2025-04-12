---
layout: post
title: Self Driving -03- Safety Assurance for Autonomous Vehicles
date: 2025-03-31 17:49 -0700
categories: [Self-driving]
tags: [Python, Self-driving, Ai, Machine Learning, Carla]
author: Diego Trazzi
---

Resources and links to reference study material.

### [Self-Driving Cars Specialization](https://www.coursera.org/specializations/self-driving-cars)

Courses in this specialization: 

* ✅ Introduction to Self-Driving Cars:
  
* __Module 02__: Autonomous Vehicle Hardware, Software and Environment Representation
  
  * __Hardware Configurations__:
  
    * __Sensors__: Camera, Radar, Lidar, Ultrasonic, GNSS/IMU, Wheel odometry
    * [ME597 - Autonomous Mobile Robotics Cours - Sensors Slides](http://wavelab.uwaterloo.ca/sharedata/ME597/ME597_Lecture_Slides/ME597-4-Measurement.pdf).
    * [Sensing requirements for an automated vehicle for highway and rural environments - Thesis](https://repository.tudelft.nl/record/uuid:2ae44ea2-e5e9-455c-8481-8284f8494e4e)
  
  * __Software Architecture__: Environment Representation, Environment Mapping, Motion Planning, Vehicle Controller, System supervisor

    <img src="data/M2 SW-Architecture.png" height="100
  "> <img src="data/M2 Environment-perception.png" height="50">  <img src="data/M2 Environmental-maps.png" height="50"> <img src="data/M2 Motion-planning.png" height="50"> <img src="data/M2 Vehicle-controller.png" height="50"> <img src="data/M2 System-supervisor.png" height="50">

      * [DARPA Urban Challenge Technical Paper](https://www.semanticscholar.org/paper/DARPA-Urban-Challenge-Technical-Paper-Reinholtz-Alberi/c10acd8c64790f7d040ea6f01d7b26b1d9a442db?p2df)
        * [Lanelets: Efficient map representation for autonomous driving](https://ieeexplore.ieee.org/abstract/document/6856487)

  * __Environment Representation__: Localization Map (dynamic), Occupancy Grid Map (static), Detailed road map (traffic regulation and road boundaries)
  
* __Module 03__: Safety Assurance for Autonomous Vehicles

  * Safety Assurance: 

    <img src="data/M3 Summary.png" height="100"> <img src="data/M3 Autonomy-design.png" height="50"> <img src="data/M3 Testing and crash mitigation.png" height="50">

  * Industry Methods for Safety Assurance and Testing:
    * Waymo Safety Levels: behavioral, functional, crash, operational and non collision safety. They also perform 10 million (simulated) miles tested on each codechange. Closed course testing and real-world testing. [Waymo Safety Report](https://waymo.com/safety/)
    * Safety Frameworks for Self-Driving:
      * Probabilistic Fault tree is a top down flow failure analysis
      * FMEA Failure Mode and Effect Analysis
      * HAZOP: Hazard and operability study (variation of FMEA)

* __Module 3__: Vehicle Dynamic Modeling
  * Kinematic vs Dynamic.

### __Module 4__: Vehicle Dynamic Modeling

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

### __Module 5__: Vehicle Dynamic Modeling

#### Lesson 1: Proportional-Integral-Derivative (PID) Control

##### **1. Basics of Longitudinal Control**
Longitudinal control ensures the car maintains the desired speed by adjusting throttle and brake commands. It uses a **feedback loop**:
- Sensors measure the car's current speed.
- The controller compares this to the desired speed.
- Based on the difference (error), it adjusts throttle/brake signals to minimize this error.

---

##### **2. PID Controller**

<div style="text-align: center;">
  <img src="data/Module 05 - Vehicle Dynamic Modeling/PID-BASICS.png" height="250">
</div>

The PID (Proportional-Integral-Derivative) controller is a fundamental tool for error correction in longitudinal control:
- **Proportional (P):** Reacts directly to the current error, speeding up response but may overshoot.
- **Integral (I):** Summarizes past errors to eliminate steady-state errors but can increase oscillations.
- **Derivative (D):** Predicts future errors to stabilize the system and reduce overshoot.

<div style="text-align: center;">
  <img src="data/Module 05 - Vehicle Dynamic Modeling/pid.png" height="150">
</div>

The PID controller combines these three terms to balance quick response, stability, and accuracy. Gains ($K_p$, $K_i$, $K_d$) must be tuned carefully for optimal performance.

---

##### **3. Transfer Functions**
- A transfer function represents how inputs (like throttle) affect outputs (like speed).
- Using Laplace transforms simplifies analyzing system behavior in terms of poles (stability) and zeros (response).
- The Laplace transform converts functions from the time domain into the frequency (or -domain). It is essential for defining transfer functions because it simplifies differential equations into algebraic equations.

---

##### **4. Closed-Loop System**
In a closed-loop system:
- The controller continuously adjusts inputs based on feedback from sensors.
- Performance metrics include:
  - **Rise Time:** How quickly the car reaches the target speed.
  - **Overshoot:** How much it exceeds the target.
  - **Settling Time:** Time to stabilize near the target speed.
  - **Steady-State Error:** Difference between actual and desired speeds once stable.

---

##### **5. PID Tuning**
Tuning methods like Ziegler-Nichols help find optimal gains for specific system responses. Adjusting $K_p$, $K_i$, $K_d$ affects:
- Speed of reaction ($K_p$).
- Elimination of steady-state error ($K_i$).
- Stability and smoothness ($K_d$).

---

##### **6. Application Example**
The spring-mass-damper model demonstrates PID control:
- Without control: The system oscillates and takes time to stabilize.
- With PID control: Proper tuning eliminates overshoot, reduces oscillations, and achieves faster stabilization.

By understanding these principles, you can design a PID controller to regulate vehicle speed effectively and improve autonomous driving performance!

---

#### Lesson 2: Longitudinal Speed Control with PID

> This lesson focuses on applying PID control to a longitudinal vehicle model, specifically for cruise control systems. Here’s a simplified breakdown:

##### **1. Vehicle Control Architecture**

<div style="text-align: center;">
  <img src="data/Module 05 - Vehicle Dynamic Modeling/vehicle-control-architecture.png" height="300">
</div>

The control architecture is divided into four sections:

1. **Perception Layer:** Sensors capture road and environmental data to generate input references.
2. **Motion Planning Layer:** Generates path and speed profiles (e.g., drive cycles) as reference inputs for controllers.
3. **Controller Layer:** Minimizes the error between actual and reference path/speed.
   - **High-Level Controller:** Determines desired acceleration based on velocity error using PID control.
   - **Low-Level Controller:** Converts desired acceleration into throttle/brake signals.
4. **Actuator Layer:** Executes commands like steering, throttle, and braking.

---

##### **2. High-Level Controller**
- Input: Velocity error (difference between reference and actual velocity).
- Output: Desired acceleration calculated using a PID controller.
- Implementation:
  - Integral term is discretized into a summation over fixed time steps.
  - Derivative term is approximated using finite differences.

---

#### **Lesson 3: Feedforward Control and Combined Feedback-Feedforward Architecture**

> This lesson introduces **feedforward control** and explains how combining **feedback** and **feedforward control** improves longitudinal speed tracking performance. Here's a simplified breakdown:

##### **1. Feedback vs. Feedforward Control**

<div style="text-align: center;">
  <img src="data/Module 05 - Vehicle Dynamic Modeling/feed-forward-loop.png" height="150">
</div>

###### **Feedback Control**
- **How it works:** Compares the current output (e.g., actual speed) to the reference signal (desired speed). The error between them is fed into the controller, which generates inputs to correct the error.
- **Purpose:** Reactive—corrects errors caused by disturbances or inaccuracies in the system.
- **Limitation:** Requires an error to exist before acting, leading to a lag in response.

###### **Feedforward Control**
- **How it works:** Directly uses the reference signal to predict and apply inputs to the system (plant) without relying on error correction.
- **Purpose:** Predictive—provides necessary inputs to achieve desired outputs, especially for non-zero commands like maintaining constant speed or steering.
- **Limitation:** Relies on accurate system modeling; errors can occur if the model is imprecise.

---

##### **2. Combined Feedback and Feedforward Control**

<div style="text-align: center;">
  <img src="data/Module 05 - Vehicle Dynamic Modeling/combined-feedback-and-forward-control.png" height="150">
</div>

- **Why combine them?**
  - Feedforward provides predictive inputs for steady-state conditions.
  - Feedback corrects errors caused by disturbances or inaccuracies in the feedforward model.
- **How it works:** The plant input is the sum of feedforward and feedback signals:
  $$
  \text{Plant Input} = \text{Feedforward Input} + \text{Feedback Input}
  $$

  ---

##### **3. Application to Longitudinal Speed Control**
###### **Reference Speed Tracking**
The combined control architecture ensures precise tracking of the reference speed:
1. **Feedforward Block:**
   - Converts reference velocity into actuator signals using a lookup table or reference map.
   - Assumes steady-state operation but ignores internal dynamics of the vehicle powertrain.

2. **Feedback Block:**
   - Uses PID control to correct velocity errors caused by disturbances or inaccuracies in the feedforward model.

---

###### **Steps for Feedforward Actuator Commands**
1. Calculate wheel angular speed based on the reference velocity using kinematic relationships.
2. Compute engine RPM from wheel angular speed via gear ratios (transmission, differential, final drive).
3. Determine required engine torque using powertrain dynamics and load torque (from aerodynamic resistance, rolling resistance, and road slope).
4. Use an engine map to find throttle position needed for the required torque, interpolating as necessary.

---

##### **4. Comparison: PID vs. Combined Feedback-Feedforward Control**
- **PID Controller:**
  - Reacts only when errors exist, leading to a lag in response during dynamic maneuvers.
  - Relies entirely on feedback correction.

- **Combined Feedback-Feedforward Controller:**
  - Predictively applies reference inputs via feedforward control, reducing lag.
  - Feedback focuses on disturbance rejection and fine-tuning.

###### Key Observations:
- Feedforward control improves tracking performance during dynamic changes in reference speed.
- However, feedforward tracking isn't perfect due to vehicle inertia and reliance on steady-state modeling.
- As feedforward models become more precise, feedback can focus solely on disturbance correction.

---

##### **5. Summary of Lesson**
- Feedforward controllers provide predictive responses for steady-state conditions.
- Feedback controllers provide reactive responses to eliminate errors caused by disturbances.
- Combining feedback and feedforward control enhances tracking performance for autonomous vehicle speed regulation.

---


## Other courses

* 🚧 State Estimation and Localization for Self-Driving Cars.
* 🚧 Visual Perception for Self-Driving Cars.
* 🚧 Motion Planning for Self-Driving Cars.