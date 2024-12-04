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
    // 01. Setup Metal environment
    guard
      let device = MTLCreateSystemDefaultDevice(),
      let commandQueue = device.makeCommandQueue() else {
      fatalError("GPU not available")
    }
    Self.device = device
    Self.commandQueue = commandQueue
    metalView.device = device

    // 02. Create the allocator + mesh
    // MTKMeshBufferAllocator manages the memory for the mesh data. It's an interface for allocating a MetalKit buffer that backs the vertex data of a Model I/O mesh.
    let allocator = MTKMeshBufferAllocator(device: device)
    let size: Float = 0.8
    // Model I/O creates the mesh and return the vertex info in data buffers
    let mdlMesh = MDLMesh(boxWithExtent: [size, size, size], segments: [1, 1, 1], inwardNormals: false, geometryType: .triangles, allocator: allocator)
    do {
      mesh = try MTKMesh(mesh: mdlMesh, device: device)
    } catch {
      print(error.localizedDescription)
    }
    // Setup the MTLBuffer that contains data to send to the GPU
    vertexBuffer = mesh.vertexBuffers[0].buffer

    // 03. Shader library
    let library = device.makeDefaultLibrary()
    Self.library = library
    let vertexFunction = library?.makeFunction(name: "vertex_main")
    let fragmentFunction = library?.makeFunction(name: "fragment_main")

    // 04. Configure the GPU state with a PIPELINE STATE OBJECT
    // The GPU needs to know its complete state before it can start managing vertices
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = vertexFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    // Set the pixel-format to match the metalView
    pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
    // Pipeline Vertex Descriptor tells the GPU how to interpret the vertex data
    pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mdlMesh.vertexDescriptor)
    // Finally convert the descriptor into a state object
    do {
      pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    } catch {
      fatalError(error.localizedDescription)
    }

    super.init()

    // Set background color
    metalView.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
    metalView.delegate = self
  }
}

// Conforming to MTKViewDelegate so we can set the Renderer as delegate of MTKView
extension Renderer: MTKViewDelegate {

  // Called every time the size of the window changes.
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  // Called every frame
  func draw(in view: MTKView) {
    // 01. Render Encoder
    guard
      // Send a command encoder to the GPU using the render-pass-descriptor form the view
      let commandBuffer = Self.commandQueue.makeCommandBuffer(),
      let descriptor = view.currentRenderPassDescriptor,
      let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
      return }
    // 02. Drawing code
    renderEncoder.setRenderPipelineState(pipelineState)
    renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
    for submesh in mesh.submeshes {
      renderEncoder.drawIndexedPrimitives(type: .triangle, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset)
    }
    // After adding the GPU commands to a command encoder, you end its encoding.
    renderEncoder.endEncoding()
    guard let drawable = view.currentDrawable else {
      return
    }
    // Present the view's drawable texture to the GPU
    commandBuffer.present(drawable)
    // Sending the encoded commands to the GPU for execution
    commandBuffer.commit()

  }
}
