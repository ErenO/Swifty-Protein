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
            self.spawnAtoms()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnAtoms()
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
    
    func spawnLigand() {
        if (self.ligandToDisplay != nil) {
            for atom in (self.ligandToDisplay?.atoms)! {
                self.spawn(atom: atom)
            }
            for connection in (self.ligandToDisplay?.connections)! {
                self.spawn(connection: connection)
            }
        }
    }
    
    func spawnAtoms() {
        if (self.ligandToDisplay != nil) {
            for atom in (self.ligandToDisplay?.atoms)! {
                self.spawn(atom: atom)
            }
            for connection in (self.ligandToDisplay?.connections)! {
                self.spawn(connection: connection)
            }
        }
    }
    
    func spawn(atom: Atom) {
        var geometry:SCNGeometry
        geometry = SCNSphere(radius: 0.1)
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
        
        scnScene.rootNode.addChildNode(geometryNode)
    }
    
    func spawn(connection: Connection) {
        var geometry:SCNGeometry
        let firstAtom = self.ligandToDisplay?.atoms[connection.atoms.0 - 1]
        let secondAtom = self.ligandToDisplay?.atoms[connection.atoms.1 - 1]
        let v1 = SCNVector3(x: (firstAtom?.x)!, y: (firstAtom?.y)!, z: (firstAtom?.z)!)
        let v2 = SCNVector3(x: (secondAtom?.x)!, y: (secondAtom?.y)!, z: (secondAtom?.z)!)
        let distance = CGFloat(v1.distance(receiver: v2))
        geometry = SCNCylinder(radius: 0.05, height: distance)
        
        let position = self.getConnectionPosition(connection: connection)           // position: middle between 2 points
        let geometryNode = SCNNode(geometry: geometry)
        
        geometryNode.position = SCNVector3(x: position.0, y: position.1, z: position.2)
        
        let rotp = v2 - SCNVector3(x: position.0, y: position.1, z: position.2)
        
        let rotx = atan2( rotp.y, rotp.x )
        geometryNode.eulerAngles = SCNVector3(0, 0, rotx)
        
        scnScene.rootNode.addChildNode(geometryNode)
    }
    
    func getConnectionPosition(connection: Connection) -> (Float, Float, Float) {
        let firstAtom = self.ligandToDisplay?.atoms[connection.atoms.0 - 1]
        let secondAtom = self.ligandToDisplay?.atoms[connection.atoms.1 - 1]
        return self.getMiddle(between: firstAtom!, and: secondAtom!)
    }
    
    func getMiddle(between first: Atom, and second: Atom) -> (x: Float, y: Float, z: Float){
        let x = (first.x + second.x) / 2
        let y = (first.y + second.y) / 2
        let z = (first.z + second.z) / 2
        return (x, y, z)
    }
    
    
}

func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
}

private extension SCNVector3{
    func distance(receiver:SCNVector3) -> Float{
        let xd = receiver.x - self.x
        let yd = receiver.y - self.y
        let zd = receiver.z - self.z
        let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
        
        if (distance < 0){
            return (distance * -1)
        } else {
            return (distance)
        }
    }
}
    
