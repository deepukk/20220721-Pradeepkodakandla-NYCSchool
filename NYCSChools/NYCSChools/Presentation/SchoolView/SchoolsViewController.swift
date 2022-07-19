//
//  SchoolsViewController.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation
import UIKit

class SchoolsViewController: UIViewController, ScchoolsViewModelDelegate {
    // UI Components
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = SchoolsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getAllSchoolsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the selected school with sat score to the destinatiion view controller
        if segue.identifier == "SchoolDetailView" {
            let detailViewController = segue.destination as! SchoolDetailTableViewController
            detailViewController.viewModel = self.viewModel.selectedSchoolDetailViewModel()
        }
    }
    
    func reload() {
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDataSource and UITableViewDelegate Extensions
extension SchoolsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SchoolTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as! SchoolTableViewCell
        
        tableView.rowHeight = 195
        cell.viewModel = self.viewModel.school(at: indexPath.row)
        return cell
    }
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectedSchoolViewModel = self.viewModel.school(at: indexPath.row)
        self.performSegue(withIdentifier:"SchoolDetailView", sender: self)
    }
}
