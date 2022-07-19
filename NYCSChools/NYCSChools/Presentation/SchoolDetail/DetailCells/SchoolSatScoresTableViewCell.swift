//
//  SchoolSatScoresTableViewCell.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import UIKit

class SchoolSatScoresTableViewCell: UITableViewCell {

    var viewModel: SchoolDetailViewModel? {
        didSet {
            self.setup()
        }
    }
    
    @IBOutlet var hsNameLbl: UILabel!
    @IBOutlet var satReadingAvgScoreLbl: UILabel!
    @IBOutlet var satMathAvgScoreLbl: UILabel!
    @IBOutlet var satWritingAvgScoreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup() {
        guard let cellModel = self.viewModel else {
            return
        }
        hsNameLbl.text = cellModel.schoolName
        satReadingAvgScoreLbl.text = cellModel.readingAvgScore
        satMathAvgScoreLbl.text = cellModel.mathAvgScore
        satWritingAvgScoreLbl.text = cellModel.writingAvgScore

        satMathAvgScoreLbl.isHidden = cellModel.isMathAvgScoreAvailable
        satWritingAvgScoreLbl.isHidden = cellModel.isWritingAvgScoreAvailable
    }

}
