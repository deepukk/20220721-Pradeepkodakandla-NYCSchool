//
//  SchoolOverviewTableViewCell.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import UIKit

class SchoolOverviewTableViewCell: UITableViewCell {

    @IBOutlet var hsOverviewLbl: UILabel!
    
    var viewModel: SchoolDetailViewModel? {
        didSet {
            self.setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setup() {
        self.hsOverviewLbl.text = self.viewModel?.overView
    }
}
