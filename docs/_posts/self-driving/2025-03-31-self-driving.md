---
layout: post
title: Self Driving
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

* __Module 4__: Vehicle Dynamic Modeling
  * Kinematic vs Dynamic.

### __Module 5__: Vehicle Dynamic Modeling

#### The Kinematic Bicycle Model: 

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

## Other courses

* 🚧 State Estimation and Localization for Self-Driving Cars.
* 🚧 Visual Perception for Self-Driving Cars.
* 🚧 Motion Planning for Self-Driving Cars.
