//
//  ProteinViewController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {

    @IBOutlet weak var mySCNView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        mySCNView.autoenablesDefaultLighting = true
        mySCNView.allowsCameraControl = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        mySCNView.scene = scnScene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 15)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        var geometry:SCNGeometry
        
        switch ShapeType.random() {
        default:
            geometry = SCNCone(topRadius: 0.25, bottomRadius: 0.5, height: 1.0)
            let geometryNode = SCNNode(geometry: geometry)
            scnScene.rootNode.addChildNode(geometryNode)
        }
    }
    
}
