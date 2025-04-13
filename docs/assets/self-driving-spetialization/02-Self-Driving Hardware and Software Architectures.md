---
layout: post
title:  Self Driving -02- Self-Driving Hardware and Software Architectures
date: 2025-03-31 17:49 -0700
categories: [Self-driving]
tags: [Python, Self-driving, Ai, Machine Learning, Carla]
author: Diego Trazzi
---

## [Self-Driving Hardware and Software Architectures](https://www.coursera.org/specializations/self-driving-cars)
  
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

---

###### REFERENCES
* ...