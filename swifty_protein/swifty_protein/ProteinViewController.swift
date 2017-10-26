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
    var ligandToDisplay: Ligand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnLigand()
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
        let cameraPosition = setCameraPosition()
        if cameraPosition == nil {
            cameraNode.position = SCNVector3Make(0, 0, 30)
        }
        else {
            cameraNode.position = cameraPosition!
        }
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func setCameraPosition() -> SCNVector3? {
        if let ligand = self.ligandToDisplay {
                if ligand.atoms.count > 0 {
                    if ligand.atoms[0].x > 10 {
                        return SCNVector3(ligand.atoms[0].x, ligand.atoms[0].y, ligand.atoms[0].z + 30)
                    }
                    return nil            // maybe not a good idea
                }
                else {
                    return nil
                }
        }
        return nil
    }
    
    func spawnLigand() {
        if let ligand = self.ligandToDisplay {
            for atom in ligand.atoms {
                self.spawn(atom: atom)
            }
            for connection in ligand.connections {
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
        let firstAtom = self.ligandToDisplay?.atoms[connection.atoms.0 - 1]
        let secondAtom = self.ligandToDisplay?.atoms[connection.atoms.1 - 1]
        let v1 = SCNVector3(x: (firstAtom?.x)!, y: (firstAtom?.y)!, z: (firstAtom?.z)!)
        let v2 = SCNVector3(x: (secondAtom?.x)!, y: (secondAtom?.y)!, z: (secondAtom?.z)!)
        
        if (firstAtom?.x == secondAtom?.x && firstAtom?.y == secondAtom?.y) {
            print("SAME")
            print(firstAtom?.z)
            print(secondAtom?.z)
        }
        self.generateCylinder(atom1: v1, atom2: v2)
    }
    
    func generateCylinder(atom1: SCNVector3, atom2: SCNVector3) {
        var geometry:SCNGeometry
        let distance = CGFloat(atom1.distance(receiver: atom2))
        geometry = SCNCylinder(radius: 0.05, height: distance)
        
        let line = SCNNode()
        line.position = atom1
        let node1 = SCNNode()
        node1.position = atom2
        scnScene.rootNode.addChildNode(node1)
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position.y = Float(distance / 2)
        
        let zAlign = SCNNode()
        
        zAlign.eulerAngles.x = -Float.pi/2
        zAlign.addChildNode(geometryNode)
        
        line.addChildNode(zAlign)
        line.constraints = [SCNLookAtConstraint(target: node1)]
        
        scnScene.rootNode.addChildNode(line)
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

