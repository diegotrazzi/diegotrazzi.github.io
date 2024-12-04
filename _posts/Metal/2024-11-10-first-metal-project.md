---
layout: post
title: Metal Rendering Pipeline
date: 2024-11-10 16:04 -0800
categories: [Metal]
tags: [Metal, MetalKit, Computer Graphics, 3D, Rendering, GPU, Apple, MacOS]
---

## Initial SwiftUI View

The MetalKit framework contains an MTKView, which is a special Metal rendering view. This is a UIView on iOS and an NSView on macOS. To interface with UIKit or Cocoa UI elements, you’ll use a Representable protocol that sits between SwiftUI and your MTKView.

Then, we set up a Renderer class that conforms to MTKViewDelegate and sets Renderer as a delegate of MTKView. MTKView calls a delegate method every frame, and this is where you’ll place the necessary drawing code.

## The Renderer Class

```swift
import MetalKit

class Renderer: NSObject {
  init(metalView: MTKView) {
    super.init()
  }
}

extension Renderer: MTKViewDelegate {

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  func draw(in view: MTKView) {
    print("draw")
  }
}
```

* `mtkView(_:drawableSizeWillChange:)`: Called every time the size of the window changes
* `draw(in:)`: Called every frame. This is where you write your render code.$$

## Initialize Metal Environment

```
Renderer.init
{...}
```

Metal has a major advantage over OpenGL in that you’re able to instantiate some objects up-front rather than create them during each frame.

The `Renderer()` initializer holds the setup of the Metal environment. We create a device which gives access to the `commandQueue`. The commanQueue will receive per-frame draw requests from the `makeCommandBuffer`, but before we submit a draw request, we need to instruct the GPU with the type of configuration we want and provide the data to render. 
We do this in the initializer as well: we first create a buffer that holds mesh information, then we load the shader library and configure the pipeline through a pipelineDescriptor. Finally we convert the descriptor into a compiled object, named `renderPipelineState`.

## Drawing

```
Renderer.draw()
{...}
```
To draw we need to setup the list of commands that the GPU needs. First, we set the pipline state object, then we feed the GPU the vertex data and issue a draw call.

### The Render Pipeline

![render-pipeline](/assets/Metal/2024-11-10-first-metal-project/render-pipeline.png){: .default width="600"}

Apple’s chips for iOS since A11, and Apple silicon for macOS, use tile-based rendering (TBR).{: .prompt-tip}

#### Vertex Fetch

We use a vertex descriptor to define the way vertices are read in along with their attributes. Model I/O imports USD files and sets up their buffers indexed by submesh. This indexing is important because vertices are cached for reuse.

#### Vertex Processing

In the Vertex Processing stage, vertices are processed individually. You write code to calculate per-vertex lighting and color. More importantly, you send vertex coordinates through various coordinate spaces to reach their position in the final framebuffer.



## References
* [A trip through the Graphics Pipeline](https://fgiesen.wordpress.com/2011/07/09/a-trip-through-the-graphics-pipeline-2011-index/)
* [Primitive Assembly](http://www.lighthouse3d.com/tutorials/glsl-tutorial/primitive-assembly/)
* [Tailor Your Apps for Apple GPUs](https://developer.apple.com/documentation/metal/tailor_your_apps_for_apple_gpus_and_tile-based_deferred_rendering)
* [Render Hell 2.0](http://simonschreibt.de/gat/renderhell/)
* [Reverse Engineering Apple G13 Architecture](https://dougallj.github.io/applegpu/docs.html)
* [GPU architecture types explained](https://www.rastergrid.com/blog/gpu-tech/2021/07/gpu-architecture-types-explained/)
* [Dissecting the Apple M1 GPU](https://rosenzweig.io/blog/asahi-gpu-part-1.html)