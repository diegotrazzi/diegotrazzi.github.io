//
//  ViewController.swift
//  RainbowTriangle
//
//  Created by mac_sys1 on 10/25/24.
//

import Cocoa
import Metal
import MetalKit

class ViewController: NSViewController {

    var mtkView: MTKView!
    var renderer: RenderDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 01. Initialize MetalKitVIew
        guard let mtkViewTemp = self.view as? MTKView else {
            print("View attached to ViewController is not an MTKView!")
            return
        }
        mtkView = mtkViewTemp
        // 02. Configuration (device, delegate)
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return
        }
        print("My GPU is \(defaultDevice)")
        mtkView.device = defaultDevice
        // 03. Create an instance of the Render Delegate and attach it to MTKView
        guard let tempRenderer = RenderDelegate(mtkView: mtkView) else {
            print("Render delegate failed to initialize")
            return
        }
        renderer = tempRenderer
        mtkView.delegate = renderer
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
