---
layout: post
title: Metal for VisionOS
date: 2024-11-02 15:15 -0700
categories: [Metal]
tags: [Metal, MetalKit, Computer Graphics, 3D, Rendering, GPU, Apple, MacOS]
---

{% include toc.html %}

## Compositor Services Framework

When creating fully immersive content with Metal, [Compositor Services](https://developer.apple.com/documentation/compositorservices) acts as a bridge between your SwiftUI code and your Metal rendering engine. This framework enables you to present an immersive scene that supports Metal rendering. When your app displays the scene, __Compositor Services provides a layer containing the Metal types, textures, and necessary information__. It also offers timing data to help you manage the rendering loop efficiently and deliver frames promptly.

### Set up an ImmersiveSpace Scene
![Desktop View](/assets/Metal/2024-11-02-metal-on-visionos/img/AppArchitecture.png){: .default width="600"}

#### CompositorLayer

During app initialization, [Compositor Services](https://developer.apple.com/documentation/compositorservices) automatically creates and configures a [LayerRenderer](https://developer.apple.com/documentation/compositorservices/layerrenderer) object to handle rendering on Apple Vision throughout the app’s lifecycle. To present your fully immersive experience, configure your app with an ImmersiveSpace scene that gets its content from a [CompositorLayer](https://developer.apple.com/documentation/compositorservices/compositorlayer) type. This type provides the `CP_OBJECT_cp_layer_renderer` type you need to set up and run your app’s custom rendering loop.

The example below demonstrates setting up the immersive space and app content. Inside the closure for CompositorLayer, create a new thread to initialize and start the rendering loop for your app.

```swift
struct TestApp: App {

    var body: some Scene {
        ImmersiveSpace(id: "immersiveSpaceID") {
            CompositorLayer { @MainActor layerRenderer in
                Renderer.startRenderLoop(layerRenderer)
            }
        }
    }
}
```

#### CompositorLayerConfiguration

In the previous example we don't provide a custom configuration because Compositor Services uses a set of default configuration values.

> If your Metal rendering engine requires specific texture layouts, pixel formats, or rendering options, specify those details when you configure your with [CompositorLayerConfiguration](https://developer.apple.com/documentation/compositorservices/compositorlayerconfiguration). 
{: .prompt-tip }

Configuration options that are available on a device might not be available in Simulator, so use the capabilities parameter to validate your choices before making them. The following example changes the pixel format to one that supports HDR values, and configures the texture layout based on the current foveation setting:

```swift
struct ContentStageConfiguration: CompositorLayerConfiguration {
    func makeConfiguration(capabilities: LayerRenderer.Capabilities, configuration: inout LayerRenderer.Configuration) {
        configuration.depthFormat = .depth32Float
        configuration.colorFormat = .rgba16Float

        let foveationEnabled = capabilities.supportsFoveation
        configuration.isFoveationEnabled = foveationEnabled

        let options: LayerRenderer.Capabilities.SupportedLayoutsOptions = foveationEnabled ? [.foveationEnabled] : []
        let supportedLayouts = capabilities.supportedLayouts(options: options)

        configuration.layout = supportedLayouts.contains(.layered) ? .layered : .dedicated
    }
}
```