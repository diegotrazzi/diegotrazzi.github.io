---
layout: post
title: Pinhole Camera
date: 2024-11-04 12:04 -0800
tags: [3D Math, Math, Matrices]
author: Diego Trazzi
math: true
---

## Objective of this article

Develop a virtual-camera model that allows us to simulate results produced by real cameras, using real-world parameters to set the camera.

### A pinhole camera model

Objects in the scene reflect light in all directions. The aperture's size is so small that, among the many rays reflected off at P, a point on the surface of an object in the scene, only a narrow beam of light rays or photons enters the camera.

![Pinhole Camera View](/assets/Math/2024-11-04-pinhole-camera/img/pinholeprinciple.png){: .default width="600"}

> Lenses refocus light reflected from object surfaces back to single points on the film, combining the benefits of a large aperture with those of a lens to achieve both short exposure times and sharp images. However, lens use introduces depth of field
{: .prompt-tip}

|                                                                                                          |                                                                                                     |
| -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| ![Pinhole Camera View](/assets/Math/2024-11-04-pinhole-camera/img/gnome-dof.png){: .default width="300"} | ![Pinhole Camera View](/assets/Math/2024-11-04-pinhole-camera/img/lens.png){: .default width="300"} |
| Depth of field                                                                                           | Lenses refocus light reflected from object surfaces back to single points on the film               |


#### Zooming in-out

> The focal length is the distance from the hole where light enters the camera to the image plane.
{: .prompt-tip}

The size of the photographic film onto which the image is projected and the distance between the hole and the back side of the box play a crucial role in how a camera captures images.

![Focal length](/assets/Math/2024-11-04-pinhole-camera/img/focallength2.png){: .left width="250"} The distance from the film plane to the aperture, which can be adjusted to vary the scene's coverage on film, commonly referred to as the focal length or focal distance, or by varying the angle (increasing or decreasing) at the apex of a triangle defined by the aperture and the film edges, known as the angle of view or field of view (AOV and FOV, respectively).
The field of view can be defined as the angle of the triangle in the horizontal or vertical plane of the camera. 

![Focal length 2](/assets/Math/2024-11-04-pinhole-camera/img/angleofview.png){: .right width=50"}
A direct relationship exists between the focal length and the angle of view. Let's denote AB as the distance from the eye to the canvas—while this distance is typically assumed to be 1, we must consider more general cases. 

Let BC represent half the canvas size (width or height), and denote half the angle of view. We can use Pythagorean trigonometric identities to determine AC if we know both (which is half the angle of view) and AB (which is the distance from the eye to the canvas). In 3D graphics, the extent of the scene visible through the camera can be determined by a triangle connecting the aperture to either the top and bottom edges of the film, defining the vertical field of view, or to the left and right edges, defining the horizontal field of view.


$$
\begin{aligned}
\tan(\theta) &= \frac{BC}{AB} \\
BC &= \tan(\theta) \times AB \\
\text{Canvas Size} &= 2 \times \tan(\theta) \times AB \\
\text{Canvas Size} &= 2 \times \tan(\theta) \times \text{Distance to Canvas}.
\end{aligned}
$$

> The extent of the scene we capture also depends on the film (or sensor) size. In photography, the size of the film or image sensor is significant. A larger surface captures a wider extent of the scene than a smaller surface. The surface size capturing the image (whether digital or film) also determines the angle of view, in addition to the focal length.
{: .prompt-tip}

Altering either one of these parameters affects the angle of view:

* When the film size is fixed, altering the focal length changes the angle of view. A longer focal length results in a narrower angle of view.
* When the focal length is fixed, changing the film size alters the angle of view. A larger film leads to a wider angle of view.

#### Aspect ratio

![Focal length](/assets/Math/2024-11-04-pinhole-camera/img/aspectratio.png){: .default width="250"}

Not preserving the canvas aspect ratio in relation to the raster image aspect ratio leads to image distortion.
To address this, software like Maya offers strategies for aligning the canvas ratio with the device aspect ratio at render time:

* The Fill mode forces the resolution gate within the film gate.
* The Overscan mode forces the film gate within the resolution gate.

![Focal length](/assets/Math/2024-11-04-pinhole-camera/img/filmgate3.png){: .default width="250"}

Ultimately, the "film gate ratio" only differs from the "resolution gate ratio" when dealing with anamorphic formats, which is relatively rare.

#### Representing Cameras in CG

![pinhole cam](/assets/Math/2024-11-04-pinhole-camera/img/pinholecam1.png){: .default width="250"}

Defining a virtual camera with a film plane in front of the camera simplifies the system as the image is not flipped upside-down and the construction leads to viewing the hole of the camera (which also serves as the center of projection) as the actual position of the eye, with the image plane being the image that the eye sees. Perspective projection is a method for creating an image through this apparatus, a sort of pyramid whose apex is aligned with the eye and whose base defines the surface of a canvas onto which the image of the 3D scene is "projected."

#### Computing the Canvas Size and the Canvas Coordinates

![canvascoordinates](/assets/Math/2024-11-04-pinhole-camera/img/canvascoordinates6.png){: .default width="250"}

The canvas coordinates are used to determine whether a point lying on the image plane is visible to the camera.
The canvas (or screen) is centered on the origin of the image plane coordinate system. These coordinates are crucial because they allow us to easily check whether a point projected on the image plane lies within the canvas and is, therefore, visible to the camera.
Knowing both the canvas coordinates and the projected coordinates makes testing the visibility of the point simple.

Let's explore how to mathematically compute these coordinates. In the second chapter of this lesson, we presented the equation to compute the canvas size (assuming the canvas is square as depicted in Figures 3, 4, and 6):

$$
\begin{aligned}
\text{Canvas Size} &= 2 \times \tan(\theta) \times \text{Distance to Canvas}.
\end{aligned}
$$

Where theta is the angle of view. Note that the vertical and horizontal angles of view are the same when the canvas is square. Since the distance from the eye to the canvas is defined as the near clipping plane, we can write:

$$
\text{Canvas Size} = 2 \times \tan\left(\frac{\theta}{2}\right) \times Z_{near}.
$$

Where Z-near is the distance between the eye and the near-clipping plane. Given that the canvas is centered on the origin of the image plane coordinate system, computing the canvas's corner coordinates is straightforward:

$$
\begin{array}{l}
\text{top} &=& &\frac{\text{canvas size}}{2},\\
\text{right} &=& &\frac{\text{canvas size}}{2},\\
\text{bottom} &=& -&\frac{\text{canvas size}}{2},\\
\text{left} &=& -&\frac{\text{canvas size}}{2}.\\
\end{array}
$$

Knowing the bottom-left and top-right canvas coordinates, we can compare the projected point coordinates with these values. 

```c
// This code prioritizes clarity over optimization to enhance understanding.
// Its purpose is to elucidate rather than obscure.
float canvasSize = 2 * tan(angleOfView * 0.5) * Znear;
float top = canvasSize / 2;
float bottom = -top;
float right = canvasSize / 2;
float left = -right;
// Compute the projected point coordinates.
Vec3f Pproj = ...;
if (Pproj.x < left || Pproj.x > right || Pproj.y < bottom || Pproj.y > top) {
    // The point is outside the canvas boundaries and is not visible.
}
else {
    // The point is within the canvas boundaries and is visible.
}
```

#### Camera to World and World to Camera Matrix

![camera2](/assets/Math/2024-11-04-pinhole-camera/img/camera2.png){: .default width="250"}

When a camera is created, by default, it is located at the origin and oriented along the negative z-axis.
The camera-to-world transformation matrix is used differently depending on whether rasterization or ray tracing is being used.

#### Rasterization

![pinholecam4](/assets/Math/2024-11-04-pinhole-camera/img/pinholecam4.png){: .left width="450"}
In rasterization, the inverse of the matrix (the world-to-camera 4x4 matrix) is used to convert points defined in world space to camera space. Once in camera space, we can perform a perspective divide to compute the projected point coordinates in the image plane.

The method of "projecting" 3D points onto the image plane and calculating the pixel coordinates of the projected points can be viewed as simulating how an image is formed inside a pinhole camera by "tracing" the path of light rays from their emission points in the scene to the eye and "recording" the position (in terms of pixel coordinates) where these rays intersect the image plane.

This process involves transforming points from world space to camera space, performing a perspective divide to compute their coordinates in screen space, converting these coordinates to NDC space, and finally, translating these coordinates from NDC space to raster space. 

> NDC space (Normalized Device Coordinates) is a coordinate system used in computer graphics to represent points after the projection transformation but before the final viewport transformation. It simplifies rendering by standardizing the range of coordinates to a consistent, device-independent format.
> Transformation Process:
> 1.	Model Space: The original 3D coordinates of objects.
> 2.	World Space: Coordinates after positioning objects within the scene.
> 3.	View Space: Coordinates relative to the camera’s perspective.
> 4.	Clip Space: After applying the projection matrix, coordinates are still in 4D (homogeneous coordinates).
> 5.	NDC Space: Dividing by the  w -component to convert to 3D normalized coordinates.
> 6.	Viewport Space: Final conversion to pixel coordinates for rendering.
{: .prompt-info}

```c
for each point in the scene {
    transform a point from world space to camera space;
    perform perspective divide (x/-z, y/-z);
    if point lies within canvas boundaries {
        convert coordinates to NDC space;
        convert coordinates from NDC to raster space;
        record point in the image;
    }
}
// connect projected points to recreate the object's edges
...
```
Essentially, you start from the geometry and "cast" light paths to the eye to find the pixel coordinates where these rays strike the image plane.

#### Ray-tracing

![pinholecam7](/assets/Math/2024-11-04-pinhole-camera/img/pinholecam7.png){: .left width="450"}

The ray-tracing algorithm can be described in three steps. First, we build a ray by tracing a line from the eye to the center of the current pixel. Then, we cast this ray into the scene and check if this ray intersects any geometry in the scene. If it does, we set the current pixel's color to the object's color at the intersection point. This process is repeated for each pixel in the image.

The operation of ray tracing, with respect to the camera model, is the opposite of how the rasterization algorithm functions. When a light ray, R, reflected off an object's surface, passes through the aperture of the pinhole camera and hits the image plane's surface, it strikes a particular pixel, X, as described earlier. In other words, each pixel, X, in an image corresponds to a light ray, R, with a given direction, D, and a given origin, O.

Contrary to the rasterization algorithm, ray tracing is "image-centric". Instead of following the natural path of the light ray, from the object to the camera (as is done with rasterization), we follow the same path but in the opposite direction, from the camera to the object.

Here is the complete algorithm in pseudo-code:

```c
for (each pixel in the image) {
    // step 1
    build a camera ray: trace a line from the current pixel location to the camera aperture;
    // step 2
    cast the ray into the scene;
    // step 3
    if (the ray intersects an object) {
        set the current pixel color with the object color at the intersection point;
    }
    else {
        set the current pixel color to black;
    }
}
```

### Implementing a Virtual Pinhole Camera Model

#### Intrinsic Parameters

* __Focal Length (Type: float)__
  * Defines the distance between the eye (the camera position) and the image plane in a pinhole camera. This parameter is crucial for calculating the angle of view. It's important not to confuse the focal length, which is used to determine the angle of view, with the distance to the virtual camera's image plane, which is positioned at the near clipping plane. In Maya, this value is expressed in millimeters (mm).

* __Camera Aperture (Type: 2 floats)__
  * Determines the physical dimensions of the film used in a real camera. This value is essential for determining the angle of view and also defines the film gate aspect ratio (Chapter 2). The physical sizes of the most common film formats, generally in inches, can be found in this Wikipedia article (in Maya, this parameter can be specified either in inches or mm).

* __Clipping Planes (Type: 2 floats)__
  * The near and far clipping planes are imaginary planes located at specific distances from the camera along the camera's line of sight. Only objects located between the camera's two clipping planes are rendered in the camera's view. Our pinhole camera model positions the canvas at the near-clipping plane (Chapter 3). It's crucial to differentiate the near-clipping plane from the focal length (see the remark above).

* __Image Size (Type: 2 integers)__
  * Specifies the output image's size in pixels. The image size also determines the resolution gate aspect ratio.

* __Fit Resolution Gate (Type: enum)__
  * An advanced option used in Maya to define the strategy when the resolution aspect ratio differs from the film gate aspect ratio.

#### Extrinsic Parameters

* __Camera to World (Type: 4x4 matrix)__
  * Defines the camera position and orientation through the camera to world transformation.

We will also need the following parameters, which we can compute from the parameters listed above:

* __Angle of View (Type: float)__
  * Computed from the focal length and the film size parameters, this represents the visual extent of the scene captured by the camera.

* __Canvas/Screen Window (Type: 4 floats)__
  * These represent the coordinates of the "canvas" (referred to as the "screen window" in RenderMan specifications) on the image plane, calculated from the canvas size and the film gate aspect ratio. Conventionally, we might place this canvas 1 unit away from the eye.

* __Film Gate Aspect Ratio (Type: float)__
  * This is the ratio of the film width to the film height, determining the shape of the image captured by the camera.

* __Resolution Gate Aspect Ratio (Type: float)__
  * The ratio between the image width and its height (in pixels), affecting how the final image will be displayed or projected.

__Computing the canvas or screen window coordinates__ is straightforward. Since the canvas is centered around the screen coordinate system origin, their values are equal to half the canvas size. They are negative if they are either below or to the left of the y-axis and x-axis of the screen coordinate system, respectively. __The canvas size depends on the angle of view and the near-clipping plane (since we decided to position the image plane at the near-clipping plane). The angle of view is determined by the film size and the focal length.__ Let's compute each one of these variables.

> Note, though, that the film format is more often rectangular than square, as mentioned several times. Thus, the angular horizontal and vertical extents of the viewing frustum are different. Therefore, we will need the horizontal angle of view to compute the left and right coordinates and the vertical angle of view to compute the bottom and top coordinates.
{: .prompt-info}

#### Computing the Canvas Coordinates: The Long Way


![canvascoordinates4](/assets/Math/2024-11-04-pinhole-camera/img/canvascoordinates4.png){: .default width="350"}

##### Find Angle of View
Let's start __finding the horizontal angle of view__, we will use a trigonometric identity that states that the tangent of an angle is the ratio of the length of the __opposite side to the length of the adjacent side__ (_SOH-CAH-TOA_):

$$
\begin{align*}
\tan\left(\dfrac{\theta_H}{2}\right) &= \dfrac{A}{B} \\
&= \color{red}{\dfrac{ \left( \text{Film Aperture Width} \times 25.4 \right) / 2 }{ \text{Focal Length} }}.
\end{align*}
$$

##### Canvas Size

Now that we have the angle of view, we can compute the canvas size. We know it depends on the angle of view and the near-clipping plane (because the canvas is positioned at the near-clipping plane). We will use the same trigonometric identity to compute the canvas size:

$$
\begin{array}{l}
\tan(\dfrac{\theta_H}{2}) = \dfrac{A}{B} =
\dfrac{\dfrac{\text{Canvas Width} } { 2 } } { Z_{near} }, \\
\dfrac{\text{Canvas Width} } { 2 } = \tan(\dfrac{\theta_H}{2}) \times Z_{near},\\
\text{Canvas Width}= 2 \times \color{red}{\tan(\dfrac{\theta_H}{2})} \times Z_{near}.
\end{array}
$$

If we want to avoid computing the trigonometric function tan(), we can substitute the function on the right-hand side of equation 1:

$$
\begin{array}{l}
\text{Canvas Width}= 2 \times \color{red}{\dfrac {\dfrac { (\text{Film Aperture Width} \times 25.4) } { 2 } } { \text{Focal Length} }} \times Z_{near}.
\end{array}
$$

Computing the left coordinate is straightforward. 
We can use the same technique to compute the top and bottom coordinates.
Here is a code snippet to compute the left and right coordinates:

```c
int main(int argc, char **argv)
{
#if 0
    // First method: Compute the horizontal and vertical angles of view first
    float angleOfViewHorizontal = 2 * atan((filmApertureWidth * inchToMm / 2) / focalLength);
    float right = tan(angleOfViewHorizontal / 2) * nearClippingPlane;
    float angleOfViewVertical = 2 * atan((filmApertureHeight * inchToMm / 2) / focalLength);
    float top = tan(angleOfViewVertical / 2) * nearClippingPlane;
#else
    // Second method: Compute the right and top coordinates directly
    float right = ((filmApertureWidth * inchToMm / 2) / focalLength) * nearClippingPlane;
    float top = ((filmApertureHeight * inchToMm / 2) / focalLength) * nearClippingPlane;
#endif

    float left = -right;
    float bottom = -top;

    printf("Screen window bottom-left, top-right coordinates %f %f %f %f\n", bottom, left, top, right);
    ...
}
```

##### Computing the Canvas Coordinates: The Quick Way
The code we wrote works just fine. However, there's a slightly faster method of computing the canvas coordinates, which is often used in production code. This method involves computing the vertical angle of view to get the bottom-top coordinates, and then multiplying these coordinates by the film aspect ratio. Given that:

$$
\text{top} = \color{red}{\dfrac {\dfrac { (\text{Film Aperture Height} \times 25.4) } { 2 } } { \text{Focal Length} }} \times Z_{near}
$$

To find the right boundary using the aspect ratio (which is Film Aperture Width / Film Aperture Height), we can substitute the calculation for top into the equation for right:

$$
\text{right} = \text{top} \times \dfrac{\text{Film Aperture Width}}{\text{Film Aperture Height}}
$$

Substituting the given formula for top:

$$
\text{right} = \left( \color{red}{\dfrac {\dfrac { (\text{Film Aperture Height} \times 25.4) } { 2 } } { \text{Focal Length} }} \times Z_{near} \right) \times \dfrac{\text{Film Aperture Width}}{\text{Film Aperture Height}}
$$

Given this substitution, the right calculation appears as:

$$
\text{right} = \dfrac {\dfrac { (\text{Film Aperture Height} \times 25.4) } { 2 } } { \text{Focal Length} } \times Z_{near} \times \dfrac{\text{Film Aperture Width}}{\text{Film Aperture Height}}
$$

Simplifying further:

$$
\text{right} = \dfrac {\dfrac { (\text{Film Aperture Width} \times 25.4) } { 2 } } { \text{Focal Length} } \times Z_{near}
$$

The following code demonstrates how to implement this solution:

```c
int main(int argc, char **argv)
{
    float top = ((filmApertureHeight * inchToMm / 2) / focalLength) * nearClippingPlane;
    float bottom = -top;
    float filmAspectRatio = filmApertureWidth / filmApertureHeight;
    float right = top * filmAspectRatio;
    float left = -right;

    printf("Screen window bottom-left, top-right coordinates %f %f %f %f\n", bottom, left, top, right);
    ...
}
```

##### Function that projects points onto the image plane

![similartriangles1](/assets/Math/2024-11-04-pinhole-camera/img/similartriangles1.png){: .default width="350"}

To compute the projected point coordinates, we use a property of similar triangles. For example, if A, B, A', B' are the opposite and adjacent sides of two similar triangles, then we can write:

$$
\begin{array}{l}
\dfrac{A}{B} = \dfrac{A'}{B'} = \dfrac{P.y}{P.z} = \dfrac{P'.y}{Z_{near}}\\
P'.y = \dfrac{P.y}{P.z} * Z_{near} 
\end{array}
$$

Given that we positioned the canvas 1 unit away from the eye, making the near clipping plane equal to 1. This simplification reduced the equation to a mere division of the point's x- and y-coordinates by its z-coordinate (in other words, we ignored 
). We will also test whether the point is visible in the function that computes the projected point coordinates. We will compare the projected point coordinates with the canvas coordinates. In the program, if any of the triangle's vertices are outside the canvas boundaries, we will draw the triangle in red (a red triangle in the image indicates that at least one of its vertices lies outside the canvas). Here is an updated version of the function for projecting points onto the canvas and computing the raster coordinates of a 3D point:

```c
bool computePixelCoordinates( 
    const Vec3f &pWorld,
    const Matrix44f &worldToCamera,
    // Bottom
    const float &b,
    // Left
    const float &l,
    // Top
    const float &t,
    // Right
    const float &r,
    const float &near,
    const uint32_t &imageWidth,
    const uint32_t &imageHeight,
    Vec2i &pRaster)
{
    Vec3f pCamera;
    worldToCamera.multVecMatrix(pWorld, pCamera);
    Vec2f pScreen;
    // Compute projected point coordinates onto image plane
    pScreen.x = pCamera.x / -pCamera.z * near;
    pScreen.y = pCamera.y / -pCamera.z * near;

    // Remap the point from screen space to NDC (Normalized Device Coordinates) space
    // We divide the point's x and y coordinates in screen space by the canvas width (2 * r) and height (2 * t)
    Vec2f pNDC;
    pNDC.x = (pScreen.x + r) / (2 * r);
    pNDC.y = (pScreen.y + t) / (2 * t);
    pRaster.x = static_cast<int>(pNDC.x * imageWidth);
    pRaster.y = static_cast<int>((1 - pNDC.y) * imageHeight);

    bool visible = true;
    if (pScreen.x < l || pScreen.x > r || pScreen.y < b || pScreen.y > t)
        visible = false;

    return visible;
}
```

##### When the Resolution Gate and Film Gate Ratios Don't Match

When the film gate aspect ratio and the resolution gate ratio don't match, there are four options to choose from:

![fitgateresolution3](/assets/Math/2024-11-04-pinhole-camera/img/fitgateresolution3.png){: .default width="400"}

* __Fill Mode__: This involves fitting the resolution gate within the film gate (the blue box is inside the red box). There are two scenarios to consider:
  * If the film aspect ratio is greater than the device aspect ratio, we must scale down the canvas's left and right coordinates to match those of the resolution gate. This is achieved by multiplying the left and right coordinates by the device aspect ratio divided by the film aspect ratio.
  * If the film aspect ratio is less than the device aspect ratio, we must scale down the canvas's top and bottom coordinates to match those of the resolution gate. This is done by multiplying the top and bottom coordinates by the film aspect ratio divided by the device aspect ratio.

* __Overscan Mode__: This method fits the film gate within the resolution gate (the red box is inside the blue box), with two cases to handle:
  * If the film aspect ratio is greater than the device aspect ratio, we need to scale up the canvas's top and bottom coordinates to align with those of the resolution gate. This requires multiplying the top and bottom coordinates by the film aspect ratio divided by the device aspect ratio.
  * If the film aspect ratio is less than the device aspect ratio, we need to scale up the canvas's left and right coordinates to align with those of the resolution gate. This is achieved by multiplying the left and right coordinates by the device aspect ratio divided by the film aspect ratio.

```c
float xscale = 1;
float yscale = 1;

switch (fitFilm) {
    default:
    case kFill:
        if (filmAspectRatio > deviceAspectRatio) {
            // Case 8a
            xscale = deviceAspectRatio / filmAspectRatio;
        } else {
            // Case 8c
            yscale = filmAspectRatio / deviceAspectRatio;
        }
        break;
    case kOverscan:
        if (filmAspectRatio > deviceAspectRatio) {
            // Case 8b
            yscale = filmAspectRatio / deviceAspectRatio;
        } else {
            // Case 8d
            xscale = deviceAspectRatio / filmAspectRatio;
        }
        break;
}

right *= xscale;
top *= yscale;
left = -right;
bottom = -top;
```

## References

* [The Pinhole Camera Model](https://www.scratchapixel.com/lessons/3d-basic-rendering/3d-viewing-pinhole-camera/how-pinhole-camera-works-part-1.html)
* [Dissecting the Camera Matrix](https://ksimek.github.io/2012/08/14/decompose/)
* [Convert world to screen coordinates and vice versa in WebGL](https://olegvaraksin.medium.com/convert-world-to-screen-coordinates-and-vice-versa-in-webgl-c1d3f2868086)
* [OpenGL Transformation](https://www.songho.ca/opengl/gl_transform.html)
* [From OpenGL to Metal – The Projection Matrix Problem](https://metashapes.com/blog/opengl-metal-projection-matrix-problem/)

