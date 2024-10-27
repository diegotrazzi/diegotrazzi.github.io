//
//  RenderDelegate.swift
//  RainbowTriangle
//
//  Created by mac_sys1 on 10/25/24.
//

import Metal
import MetalKit

class RenderDelegate: NSObject, MTKViewDelegate {

    /**
    Metal needs a queue of commands that are waiting to be executed on the GPU
     The commands inside the queue are stored inside the command-buffer (per-frame-draw)
     The pipelineState represents a compiled version of the pipelineDescriptor
     **/
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    let pipelineState: MTLRenderPipelineState
    let vertexBuffer: MTLBuffer
    // Animation:
    let fragmentUniformBuffer: MTLBuffer
    // This keeps track of the system time of the last render
    var lastRenderTime: CFTimeInterval? = nil
    // This is the current time in our app, starting at 0, in units of seconds
    var currentTime: Double = 0
    // A semaphore prevents race condition between CPU/GPU
    let gpuLock = DispatchSemaphore(value: 1)

    // Create vertex data (Triangle) - CPU bound
    let vertices = [
        Vertex(color: [1,0,0,1], pos: [-1,-1]),
        Vertex(color: [0,1,0,1], pos: [0,1]),
        Vertex(color: [0,0,1,1], pos: [1,-1])
    ]

    // Initializer for the Renderer class
    init?(mtkView: MTKView) {
        device = mtkView.device!
        commandQueue = device.makeCommandQueue()!
        // Define MTLPipelineDescriptor and compile into a MTLRenderPipelineState
        do {
            pipelineState = try RenderDelegate.buildRenderPipelineWith(device: device, metalKitView: mtkView)
        } catch {
            print("Unable to compile render pipeline state \(error)")
            return nil
        }
        // Initialize the vertex buffer to store the triangle
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride)!
        // Initialize the uniform buffer (for animation)
        var initialFragmentUniforms = FragmentUniforms(brightness: 1.0)
        fragmentUniformBuffer = device.makeBuffer(bytes: &initialFragmentUniforms, length: MemoryLayout<FragmentUniforms>.stride)!
    }

    // MTKView calls this function whenever the size of the view changes
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        return
    }

    // Called whenever the View wants to draw new content
    func draw(in view: MTKView) {
        // 00. Semaphore to prevent race conditions
        gpuLock.wait()
        // 00. Compute time difference (Animation)
        let systemTime = CACurrentMediaTime()
        let timeDifference = (lastRenderTime == nil) ? 0 : (systemTime - lastRenderTime!)
        lastRenderTime = systemTime
        update(dt: timeDifference)
        // 01. Create & configure the command buffer using descriptor and encoder
        guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }
        // 02-A. MTLRenderPassDescriptor configures the options for the render pass held by MTKView
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.2, 0.3, 0.4, 1)
        // 02-B. Customize the MTLRenderPassDescriptor and compile it into a MTLRenderPipelineState (?)
        // The above step is done in the initializer
        // 03-A. Encode the command-buffer
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        // 03-B. Add the customized pipelineState (which enables shaders) to the encoder
        renderEncoder.setRenderPipelineState(pipelineState)
        // 03-C. Set the vertex buffer in the encoder
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        // 03-D. Bind the fragmentUniforms to the encoder (Animation)
        renderEncoder.setFragmentBuffer(fragmentUniformBuffer, offset: 0, index: 0)
        // 03-E. Set the encoder to draw primitives on screen
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        renderEncoder.endEncoding()
        // 04. Tell Metal to send the rendering result to MTKView when complete
        commandBuffer.present(view.currentDrawable!)
        // 05. Send the encoded command to the buffer on the GPU
        commandBuffer.addCompletedHandler { _ in
            self.gpuLock.signal()
        }
        commandBuffer.commit()
    }

    // Creates a compiled version of the pipeline descriptor used by the render encoder to execute commands on the GPU
    class func buildRenderPipelineWith(device: MTLDevice, metalKitView: MTKView) throws -> MTLRenderPipelineState {
        // 01. Create a custom MTLRenderPipelineDescriptor
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        // 02. Load and Attach shaders
        let library = device.makeDefaultLibrary()
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        // 03. Setup the output pixel format to match MTKView
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalKitView.colorPixelFormat
        // 04. Compile the descriptor into a pipeline state object
        return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }

    // Update function to set the brightness to a cosine wave that smoothly animates between 1 and 0.
    func update(dt: CFTimeInterval) {
        let ptr = fragmentUniformBuffer.contents().bindMemory(to: FragmentUniforms.self, capacity: 1)
        ptr.pointee.brightness = Float(0.5 * cos(currentTime) + 0.5)
        currentTime += dt
    }
}
