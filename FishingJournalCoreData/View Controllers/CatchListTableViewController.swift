//
//  CatchListTableViewController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/23/21.
//

import UIKit

class CatchListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    //MARK: - Properties
    var catches: [Catch] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        tableView.isEditing.toggle()
//        if tableView.isEditing == true {
//
//            navigationItem.leftBarButtonItem?.title = "Done"
//        } else {
//            editButtonItem.title = "Edit"
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CatchController.shared.fetchCatches()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CatchController.shared.catches.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "catchCell", for: indexPath) as? CatchTableViewCell else { return UITableViewCell() }
        let `catch` = CatchController.shared.catches[indexPath.row]
        cell.`catch` = `catch`
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let catchToDelete = CatchController.shared.catches[indexPath.row]
            CatchController.shared.deleteCatch(catch: catchToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCatchDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? CatchDetailViewController else { return }
            let `catch` = CatchController.shared.catches[indexPath.row]
            destination.`catch` = `catch`
        } else if segue.identifier == "toCatchModalVC" {
            guard let destination = segue.destination as? CatchModalViewController else { return }
            destination.delegate = self
        }
    }
}//End of class

//MARK: - Extensions
extension CatchListTableViewController: ModalDelegate {
    func updateMyViews() {
        CatchController.shared.fetchCatches()
        self.tableView.reloadData()
    }
}//End of extension

extension CatchListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
    }
}


