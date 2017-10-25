//
//  ProteinTableViewController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProteinTableViewController: UIViewController  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var proteinList: [String]!
    var filteredData: [String]?
    var isSearching: Bool = false
    var ligandToDisplay: Ligand?
    var networkController: NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = UserDefaults.standard
        networkController = NetworkController()
        
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        proteinList = session.array(forKey: "ligands") as? [String]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableToProtein" {
            if let vc = segue.destination as? ProteinViewController {
                print("setting ligand")
                vc.ligandToDisplay = self.ligandToDisplay!
            }
        }
    }
    
    func displayErrorAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ProteinTableViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
            return filteredData?.count ?? 0
        }
        return proteinList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "proteinCell") as? ProteinTableViewCell {
            if isSearching {
                cell.name.text = self.filteredData?[indexPath.row] ?? "default"
            }
            else {
                cell.name.text = self.proteinList?[indexPath.row] ?? "default"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("i selected a row")
        let textSelected = self.proteinList[indexPath.row]
        networkController.loadPDB(of: textSelected) { res in
            guard let response = res else {
                self.displayErrorAlert()
                return
            }
            self.ligandToDisplay = response as? Ligand
            print("callback")
            self.performSegue(withIdentifier: "TableToProtein", sender: nil)
        }
    }
}

extension ProteinTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.isSearching = false
            
            view.endEditing(true)
            
            tableview.reloadData()
        }
        else {
            self.isSearching = true
            filteredData = proteinList.filter {
                if  $0.range(of: searchText) == nil {
                    return false
                }
                return true
            }
            tableview.reloadData()
        }
    }
}
