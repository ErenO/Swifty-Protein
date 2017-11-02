//
//  ProteinViewController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import SceneKit
import Alamofire
import SWXMLHash

class ProteinViewController: UIViewController {
    
    @IBOutlet weak var mySCNView: SCNView!
    var sceneController: SceneController!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var ligandToDisplay: Ligand?
    var xml: XMLIndexer!
    var tappedNode: SCNNode? {
        willSet {
            if let elem =  newValue!.name {
                selectedElem.text = "Selected element: " + elem
            } else {
                selectedElem.text = ""
            }
        }
    }
    
    @IBOutlet weak var selectedElem: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var infosBtnCorner: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneController = SceneController(scnView: mySCNView)
        sceneController.connectedVC = self
        sceneController.set(ligand: self.ligandToDisplay!)
        sceneController.displayLigand(type: 0)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        infosBtnCorner.layer.cornerRadius = 4
        display()
    }
    
    @IBAction func modelType(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            sceneController.delete_nodes()
            sceneController.displayLigand(type: 0)
        case 1:
            sceneController.delete_nodes()
            sceneController.displayLigand(type: 1)
        default:
            break;
        }
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
    
    func display() {
        loadXML(of: self.title!) { response in
            print("callback")
            //            print(response)
            self.xml = SWXMLHash.config {
                config in
                config.shouldProcessLazily = true
                }.parse(response as! String)
        }
    }
    
    func loadXML(of: String, callback:@escaping ((Any) -> Void)) {
        Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
            if response.response?.statusCode == 200 {
                let fileData = String(data: response.data!, encoding: .utf8)
                callback(fileData!)
            }
        })
        
    }
    
    func setTitle(str: String) {
        self.title = str
    }
    
    func getPath(with: String) -> String {
        return "http://files.rcsb.org/ligands/view/" + self.title! + ".xml"
    }
    
    @IBAction func InfoBtn(_ sender: Any) {
        performSegue(withIdentifier: "ProtToInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProtToInfo" {
            if let vc = segue.destination as? InfoVC {
                vc.title = self.title
//                print( self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:name"].element?.text ?? "hello")
                vc.name = self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:name"].element?.text ?? "Error"
//                print(self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:formula"].element?.text  ?? "bite")
                vc.formula = self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:formula"].element?.text ?? "Error"
//                print( self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:formula_weight"].element?.text  ?? "bite")
                vc.weight = self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:formula_weight"].element?.text ?? "Error"
//                print(self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:type"].element?.text ?? "bite")
                vc.type = self.xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:type"].element?.text ?? "Error"
            }
        }
    }
    
}
