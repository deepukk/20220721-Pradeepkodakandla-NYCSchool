//
//  SchoolContactTableViewCell.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import UIKit

class SchoolContactTableViewCell: UITableViewCell {

    @IBOutlet var hsAddressLbl: UILabel!
    @IBOutlet var hsPhoneLbl: UILabel!
    @IBOutlet var hsWebsiteLbl: UILabel!
    
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
        self.hsAddressLbl.text = self.viewModel?.address
        self.hsPhoneLbl.text = self.viewModel?.phone
        self.hsWebsiteLbl.text = self.viewModel?.website
    }
}
