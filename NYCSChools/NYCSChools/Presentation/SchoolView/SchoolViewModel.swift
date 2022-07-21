//
//  SchoolViewModel.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation
import UIKit

class SchoolViewModel {
    var school: School
    var randomColor: UIColor
    let networkService = NetWorkService()
    
    var address: String {
        if let schoolAddress = school.location {
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
    var dbn: String? {
        self.school.dbn
    }

    init(with school: School) {
        self.school = school
        self.randomColor = UIColor.randomColorForCardViewCell()
    }
}

extension UIColor {
    //random color generator for a school
    class func randomColorForCardViewCell() -> UIColor {
        let lightRed: UIColor? = UIColor(red: 0.925, green: 0.290, blue: 0.255, alpha: 1.00)
        let lightBlue: UIColor? = UIColor(red: 0.000, green: 0.639, blue: 0.812, alpha: 1.00)
        let lightGray: UIColor? = UIColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1.00)
        let indigo: UIColor? = UIColor(red: 0.361, green: 0.420, blue: 0.753, alpha: 1.00)
        let green: UIColor? = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.00)
        let yellow: UIColor? = UIColor(red: 1.000, green: 0.933, blue: 0.345, alpha: 1.00)
        let deepOrange: UIColor? = UIColor(red: 1.000, green: 0.439, blue: 0.263, alpha: 1.00)
        
        let sideBarColorArr: [UIColor] = [lightRed!, lightBlue!, lightGray!, indigo!, green!, yellow!, deepOrange!]
        
        let randomNumber = arc4random_uniform(UInt32(sideBarColorArr.count))
        
        return sideBarColorArr[Int(randomNumber)]
    }
    
}
