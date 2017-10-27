//
//  SceneController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation
import SceneKit

class SceneController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var ligandToDisplay: Ligand?
    
    init(scnView: SCNView) {
        setupView(view: scnView)
        setupScene()
        setupCamera()
    }
    
    func setupView(view: SCNView) {
        self.scnView = view
        self.scnView.autoenablesDefaultLighting = true
        self.scnView.allowsCameraControl = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleFrontTap(sender:)))
//        scnView.addGestureRecognizer(tap)
        scnView.isUserInteractionEnabled = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        self.scnView.scene = scnScene
    }
    
    func setupCamera() {
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        
        let cameraPosition = setCameraPosition()
        
        if cameraPosition == nil {
            self.cameraNode.position = SCNVector3Make(0, 0, 30)
        }
        else {
            self.cameraNode.position = cameraPosition!
        }
        self.scnScene.rootNode.addChildNode(cameraNode)
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
    
    func set(ligand: Ligand) {
        self.ligandToDisplay = ligand
    }
    
//    @objc func handleFrontTap(sender: UITapGestureRecognizer) {
//        if sender.state == UIGestureRecognizerState.recognized
//        {
//            let location: CGPoint = sender.location(in: sender.view)
//            let hits = self.scnView.hitTest(location, options: nil)
//            if let tappedNode = hits.first?.node {
//                print(tappedNode)
//                // do something with the tapped node ...
//            }
//        }
//    }
    
    func displayLigand() {
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
        
//        if (firstAtom?.x == secondAtom?.x && firstAtom?.y == secondAtom?.y) {
//            print("SAME")
//            print(firstAtom?.z)
//            print(secondAtom?!.z)
//        }
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
