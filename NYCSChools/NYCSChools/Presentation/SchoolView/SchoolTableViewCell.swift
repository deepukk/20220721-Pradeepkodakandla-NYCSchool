//
//  SchoolTableViewCell.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//
import UIKit


class SchoolTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet var cardView: UIView?
    @IBOutlet var sideBarView: UIView?
    
    @IBOutlet var schoolNameLbl: UILabel?
    @IBOutlet var schoolAddrLbl: UILabel?
    @IBOutlet var schoolPhoneNumBtn: UIButton?
    @IBOutlet var navigateToAddrBtn: UIButton?
    
    var viewModel:SchoolViewModel? {
        didSet {
            self.setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chooseRandomColorForCard()
        setupCardViewShadows()
        
        schoolPhoneNumBtn?.layer.cornerRadius = 15
        navigateToAddrBtn?.layer.cornerRadius = 15
    }
    
    // MARK: Card View Customization Functions
    
    func chooseRandomColorForCard(){
       sideBarView?.backgroundColor = UIColor.randomColorForCardViewCell()
    }
    
    func setupCardViewShadows(){
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }
    
    func setup() {
        schoolNameLbl?.text = viewModel?.school.schoolName
        if let address = self.viewModel?.school.location {
            schoolAddrLbl?.text = "Address: \(address)"
        }
        if let phoneNum = self.viewModel?.school.phoneNumber{
            schoolPhoneNumBtn?.setTitle("Phone # \(phoneNum)", for: .normal)
        }
    }
}

