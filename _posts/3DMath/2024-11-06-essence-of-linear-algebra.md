---
layout: post
title: Essence of linear algebra
date: 2024-11-06 16:13 -0800
categories: [Math]
tags: [Linear Algebra, Vectors, Math, Matrices]
author: Diego Trazzi
---

{% include toc.html %}

## Vectors

$$
\begin{bmatrix} x \\\ y \\\ z\end{bmatrix}
$$


* How to define a vector
* Vector addition and multiplication
* i-hat and j-hat
* Span of a vector
* __Linear__ transformations: it's linear if it lines are not curved and origin must be fixed in place
* Matrices


### Normalize a vector

#### Matrix transformation

$$
\begin{bmatrix} a \ c \\\ b \ d \end{bmatrix}
\begin{bmatrix} x \\\ y \end{bmatrix} =
x\begin{bmatrix} a \\\ b\end{bmatrix}+
y\begin{bmatrix} c \\\ d \end{bmatrix}=
\begin{bmatrix} xa+yc \\\ xb+yd\end{bmatrix}
$$

With this transformation matrix we can transform (translate, rotate and scale) any point in space. 
The transform matrix represents the new position of the base vectors: $\hat{i}$ and $\hat{j}$

### References

* [Essence of Linear Algebra - 3Blue1Brown](https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab)
