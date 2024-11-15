//
//  Renderer.swift
//  MetalPipeline
//
//  Created by mac_sys1 on 11/10/24.
//

import MetalKit

class Renderer: NSObject {

  static var device: MTLDevice!
  static var commandQueue: MTLCommandQueue!
  static var library: MTLLibrary!
  var mesh: MTKMesh!
  var vertexBuffer: MTLBuffer!
  var pipelineState: MTLRenderPipelineState!

  init(metalView: MTKView) {
    // Setup Metal device and cmd-queue
    guard
      let device = MTLCreateSystemDefaultDevice(),
      let commandQueue = device.makeCommandQueue() else {
      fatalError("GPU not available")
    }
    Self.device = device
    Self.commandQueue = commandQueue
    // Sets this class as delegate from MetalView, so that the view will call MTKViewDelegate drawing methods
    metalView.device = device

    // Create the mesh
    let allocator = MTKMeshBufferAllocator(device: device)
    let size: Float = 0.8
    let mdlMesh = MDLMesh(boxWithExtent: [size, size, size], segments: [1, 1, 1], inwardNormals: false, geometryType: .triangles, allocator: allocator)
    do {
      mesh = try MTKMesh(mesh: mdlMesh, device: device)
    } catch {
      print(error.localizedDescription)
    }

    super.init()

    metalView.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
    metalView.delegate = self
  }
}

extension Renderer: MTKViewDelegate {

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  func draw(in view: MTKView) {
    print("draw")
  }
}
