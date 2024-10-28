---
layout: post
title: Systems of Linear Equation
date: 2024-10-27 15:21 -0700
categories: [Math]
tags: [Linear Algebra, Systems of Linear Equation, Determinant, Ai, Machine Learning, Math, Matrices]
---

# Systems of Linear Equation
## The Determinant

![summary](/assets/Math/2024-10-27-systems-of-linear-equation/img/summary.png){: width="300"}

---
### Systems of Sentences
When a system is __redundant__ or __contradictory__, it's called a __singular system__. And when a system is __complete__, it's called a __non-singular system__. In a nutshell, a non singular system is a system that carries as many pieces of information as sentences. So it's the most informative system can be, and a singular system is less informative than a non-singular one.

Example:
$$ 
\begin{cases} 
a+b+c=10 \\
2a+2b+2c=20 \\
3a+3b+3c=30 \\
\end{cases}
$$
There are infinite solutions because any three numbers that add to 10 works.

---
### Linear dependence and independence
I will show you a way to tell if a matrix is __singular or non-singular directly__, without having to solve the system of linear equations. But first, let us look back at systems of sentences. Recall that a system of sentences is singular if the second sentence carries the same information as the first one. Similarly, __a system of equation is singular if the second equation carries the same information as the first one__. Therefore we try to find relationship between equations to determine if are linearly independent or not.

![linear-dipendence](/assets/Math/2024-10-27-systems-of-linear-equation/img/linear-dipendence.png){: width="500"}

---
### The Determinant
__To determine if a matrix is singular or non-singular more quickly we use the determinant__

![linear-dipendence](/assets/Math/2024-10-27-systems-of-linear-equation/img/determinant.png){: width="500"}

If the __Determinant__ is zero, then is a __singular system__.

For larger matrices, like 3x3 we use the sum of the diagonals such as: 

![determinant](/assets/Math/2024-10-27-systems-of-linear-equation/img/determinant-3x3.png){: width="500"}

![determinant](/assets/Math/2024-10-27-systems-of-linear-equation/img/determinant-3x3-solution.png){: width="500"}

To __determine if a system of linear equations can be solved, understanding the determinant of its associated matrix is crucial__. The determinant serves as a quick calculation that reveals if a matrix is singular (non-invertible) or non-singular (invertible). Specifically, if the determinant equals zero, the matrix is singular, which means there’s no unique solution to the system (often due to dependencies among the equations). Conversely, if the determinant is non-zero, the matrix is non-singular, ensuring the system has a unique solution.

In summary, determining the determinant offers a foundational check for solving systems of equations, clarifying if a unique solution is possible or if the system lacks independent information, making a solution impossible.

![Notations](/assets/Math/2024-10-27-systems-of-linear-equation/img/notations.png){: width="500"}
