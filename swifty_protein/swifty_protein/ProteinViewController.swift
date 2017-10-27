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
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var mySCNView: SCNView!
    var sceneController: SceneController!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var ligandToDisplay: Ligand?
    var modelSelected = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneController = SceneController(scnView: mySCNView)
        sceneController.set(ligand: self.ligandToDisplay!)
        tabBar.selectedItem = tabBar.items?.first
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func toggleLigandTurn(_ sender: Any) {
        print("toggle")
        sceneController.toggleRotate()
    }
    
    func shareLigand() {
        print("sharing")
        let imageToShare = self.mySCNView.snapshot()
        let messageToShare = Contants.personalizedMessage + (self.ligandToDisplay?.name)!
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [(imageToShare), messageToShare], applicationActivities: nil)
        self.present(shareVC, animated: true, completion: nil)
    }
    
}

extension ProteinViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(self.modelSelected)
        
        if self.modelSelected == 1 {
            print("charging")
            self.modelSelected = 2
            sceneController.displayBallsAndSticks()
        }
        else {
            self.modelSelected = 1
        }
    }
}
