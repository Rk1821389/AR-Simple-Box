//
//  ViewController.swift
//  SimpleBox
//
//  Created by Manoj kumar on 11/02/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let box = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        box.materials = [material]
        
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(x: 0, y: 0, z: -0.5)
        
        self.sceneView.scene.rootNode.addChildNode(boxNode)
        
        
        //Rotation
        let rotationDuration: TimeInterval = 6
        let xRotation = CGFloat(GLKMathDegreesToRadians(-390))
        let yRotation = CGFloat(GLKMathDegreesToRadians(45))
        let zRotation = CGFloat(GLKMathDegreesToRadians(60))

        let rotationAction = SCNAction.rotateBy(x: xRotation, y: yRotation, z: zRotation, duration: rotationDuration)
        rotationAction.timingMode = .easeInEaseOut

        boxNode.runAction(rotationAction) {
            print("X:", GLKMathDegreesToRadians(boxNode.simdRotation.x))
            print("Y:", GLKMathDegreesToRadians(boxNode.simdRotation.y))
            print("Z:", GLKMathDegreesToRadians(boxNode.simdRotation.z))
            print("Cube Node Transform", boxNode.simdTransform)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

  
}
