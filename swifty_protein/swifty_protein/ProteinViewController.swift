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
    var ligandToDisplay: Ligand? {
        didSet {
            self.spawnShape()
        }
    }
    
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
        if (self.ligandToDisplay != nil) {
            for atom in (self.ligandToDisplay?.atoms)! {
                var geometry:SCNGeometry
                geometry = SCNSphere(radius: 0.1)
                let geometryNode = SCNNode(geometry: geometry)
                geometryNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
                scnScene.rootNode.addChildNode(geometryNode)
            }
        }
    }
    
}
