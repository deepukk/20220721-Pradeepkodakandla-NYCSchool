//
//  SchoolDetailViewController.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation
import CoreLocation
import MapKit

class SchoolDetailTableViewController: UITableViewController, SchoolDetailViewModelDelegate {
    
    var viewModel: SchoolDetailViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.schoolName
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SchoolDetailTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = SchoolDetailViewModel.RowType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        switch rowType {
        case .satScores:
            let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailViewModel.CellIdentifiers.schoolWithSATScoreCellIdentifier) as! SchoolSatScoresTableViewCell
            cell.viewModel = self.viewModel
            return cell
        case .overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailViewModel.CellIdentifiers.schoolOverviewCellIdentifier) as! SchoolOverviewTableViewCell
            cell.viewModel = self.viewModel
            return cell
        case .contact:
            let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailViewModel.CellIdentifiers.schoolWithContactCellIdentifier) as! SchoolContactTableViewCell
            cell.viewModel = self.viewModel
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailViewModel.CellIdentifiers.schoolWithAddressCellIdentifier) as! SchoolAddressTableViewCell
            cell.viewModel = self.viewModel
            return cell
        }
    }
    
    //MARK: - UITable View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = SchoolDetailViewModel.RowType(rawValue: indexPath.row) else {
            return UIScreen.main.bounds.width * 0.7
        }

        switch rowType{
        case .satScores, .overview, .contact:
            return UITableView.automaticDimension
        default:
            return UIScreen.main.bounds.width * 0.7
        }
    }
}
