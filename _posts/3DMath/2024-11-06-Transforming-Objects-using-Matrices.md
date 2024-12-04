---
layout: post
title: 3D Projection Matrix
date: 2024-11-06 16:36 -0800
categories: [Math]
tags: [Linear Algebra, Vectors, Math, Matrices]
author: Diego Trazzi
---

## The transform MAtrix

$$
\begin{bmatrix} a \ c \\\ b \ d \end{bmatrix}
\begin{bmatrix} x \\\ y \end{bmatrix} =
x\begin{bmatrix} a \\\ b\end{bmatrix}+
y\begin{bmatrix} c \\\ d \end{bmatrix}=
\begin{bmatrix} xa+yc \\\ xb+yd\end{bmatrix}
$$

With this transformation matrix we can transform (translate, rotate and scale) any point in space. 
The transform matrix represents the new position of the base vectors: $\hat{i}$ and $\hat{j}$

## 3D object manipulation

![pipelinew](/assets/Math/2024-11-06-Transforming-Objects-using-Matrices/img/transform-pipeline.png){: .center width="600"}

Objects are first transformed from object space to world space. If rasterization is used, objects are then transformed from world-to-camera space. Vertices are then projected onto the screen (using the perspective projection matrix) to screen space and then remapped to NDC (as part of the perspective projection matrix). Finally, points on the image plane in NDC coordinates are converted to their final raster or pixel coordinates.

![transform](/assets/Math/2024-11-06-Transforming-Objects-using-Matrices/img/cow-transform.png){: .center width="400"}

A 4x4 matrix is commonly used in 3D graphics to represent transformations, including translation, scaling, rotation, and projection. These transformations modify a point’s or vector’s position, orientation, or size in 3D space.

## Structure of a 4x4 Matrix

A 4x4 matrix is structured as follows:

$$
\begin{bmatrix}
m_{00} & m_{01} & m_{02} & m_{03} \\
m_{10} & m_{11} & m_{12} & m_{13} \\
m_{20} & m_{21} & m_{22} & m_{23} \\
m_{30} & m_{31} & m_{32} & m_{33}
\end{bmatrix}
$$

Each element $m_{ij}$ represents a value in the matrix, where $i$ is the row index (0–3) and $j$ is the column index (0–3).

A 3D point is represented as a column vector in homogeneous coordinates with 4 elements:

$$
\begin{bmatrix} x \\ y \\ z \\ 1 \end{bmatrix}
$$

where:
	•	$x$ ,$y$ and $z$ are the 3D coordinates of the point.
	•	The 4th element, $1$, is the homogeneous coordinate that allows transformations like translation to work with matrices.

## Applying the Matrix to a Point

To apply a 4x4 transformation matrix to a point $P=\begin{bmatrix} x \\ y \\ z \\ 1 \end{bmatrix}$, you multiply as follows:

$$
\begin{bmatrix}
m_{00} & m_{01} & m_{02} & m_{03} \\
m_{10} & m_{11} & m_{12} & m_{13} \\
m_{20} & m_{21} & m_{22} & m_{23} \\
m_{30} & m_{31} & m_{32} & m_{33}
\end{bmatrix}
\begin{bmatrix} x \\ y \\ z \\ 1 \end{bmatrix} =
\begin{bmatrix} x' \\ y' \\ z' \\ w' \end{bmatrix}
$$

The resulting components are:
$$
x' = m_{00}x + m_{01}y + m_{02}z + m_{03} \\
y' = m_{10}x + m_{11}y + m_{12}z + m_{13} \\
z' = m_{20}x + m_{21}y + m_{22}z + m_{23} \\
w' = m_{30}x + m_{31}y + m_{32}z + m_{33}
$$

If the transformation matrix includes a projection, you may need to __normalize the result by dividing each component by $w'$__, converting it back to 3D space.

## Types of Transformations and Their Matrices

1. __Translation (Moving)__: A translation matrix that moves an object by $tx$, $ty$ and $tz$ is:

$$
\begin{bmatrix}
1 & 0 & 0 & tx \\
0 & 1 & 0 & ty \\
0 & 0 & 1 & tz \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

2. __Rotation (Rotating)__: A rotation matrix around the X,Y,Z axis by an angle $\theta$ is:

$$
X =
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & \cos(\theta) & -\sin(\theta) & 0 \\
0 & \sin(\theta) & \cos(\theta) & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

$$
Y =
\begin{bmatrix}
\cos(\theta) & 0 & \sin(\theta) & 0 \\
0 & 1 & 0 & 0 \\
-\sin(\theta) & 0 & \cos(\theta) & 0 \\
0 & 0 & 0 & 1 \\
\end{bmatrix}
$$

$$
Z =
\begin{bmatrix}
\cos(\theta) & -\sin(\theta) & 0 & 0 \\
\sin(\theta) & \cos(\theta) & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 \\
\end{bmatrix}
$$

3.	__Scaling (Resizing)__: A scaling matrix with factors $sx$, $sy$, and $sz$ along the X, Y, and Z axes is:

$$
\begin{bmatrix}
sx & 0  & 0  & 0 \\
0  & sy & 0  & 0 \\
0  & 0  & sz & 0 \\
0  & 0  & 0  & 1
\end{bmatrix}
$$

4.	__Projection (Perspective)__: A perspective projection matrix, with field of view $fov$, aspect ratio $aspect$, near plane $near$, and far plane $far$, is:

$$
\begin{bmatrix}
\frac{1}{\text{aspect} \cdot \tan(\frac{fov}{2})} & 0 & 0 & 0 \\
0 & \frac{1}{\tan(\frac{fov}{2})} & 0 & 0 \\
0 & 0 & \frac{far + near}{far - near} & \frac{2 \cdot far \cdot near}{far - near} \\
0 & 0 & -1 & 0
\end{bmatrix}
$$

### Example Calculation

Suppose you have a point $P=\begin{bmatrix} 1 \\ 2 \\ 3 \\ 1 \end{bmatrix}$ and want to translate it by $(5,-3,2)$. The translation matrix is:

$$
\begin{bmatrix}
1 & 0 & 0 & 5 \\
0 & 1 & 0 & -3 \\
0 & 0 & 1 & 2 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

Multiplying this matrix with $P$:

$$
\begin{bmatrix}
1 & 0 & 0 & 5 \\
0 & 1 & 0 & -3 \\
0 & 0 & 1 & 2 \\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix} 1 \\ 2 \\ 3 \\ 1 \end{bmatrix} =
\begin{bmatrix} 6 \\ -1 \\ 5 \\ 1 \end{bmatrix}
$$

The resulting point after translation is $P'=\begin{bmatrix} 6 \\ -1 \\ 5 \end{bmatrix}$.

### Matrix multiplication as composition

In the context of matrix multiplication, especially in 3D graphics, matrix multiplication represents the composition of transformations—that is, applying one transformation after another. The order in which these transformations are applied does matter because matrix multiplication is generally not commutative:  

$$A \cdot B \neq B \cdot A$$

#### Why Order Matters

Each transformation matrix—whether for translation, scaling, or rotation—changes the coordinates or orientation of points in a specific way. When you compose transformations, you’re applying each matrix to the transformed output of the previous one, not to the original points.

#### Order of Multiplication

The standard graphics pipeline in 3D rendering applies transformations from right to left:

1.	Local transformations (object’s own scale, rotation, translation),
2.	World transformation (positioning within the world),
3.	View transformation (camera positioning),
4.	Projection transformation (perspective/orthogonal projection).

So, if you multiply matrices as  $P \cdot V \cdot W \cdot L$, you’re transforming a point in the object’s local space all the way to screen space in the correct order.

## References

* [Transforming Objects using Matrices - Scratchpixel](https://www.scratchapixel.com/lessons/3d-basic-rendering/transforming-objects-using-matrices/using-4x4-matrices-transform-objects-3D.html)
* [Essence of Linear Algebra - 3Blue1Brown](https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab)
* [ARKit – What do the different columns in Transform Matrix represent?](https://stackoverflow.com/questions/45437037/arkit-what-do-the-different-columns-in-transform-matrix-represent/55695304#55695304)
