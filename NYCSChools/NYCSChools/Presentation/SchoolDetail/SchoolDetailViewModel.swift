//
//  SchoolDetailViewModel.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation
import CoreLocation

protocol SchoolDetailViewModelDelegate: AnyObject {
    func reload()
}

class SchoolDetailViewModel {
    enum RowType: Int {
        case satScores
        case overview
        case contact
        case address
    }

    let school: School
    let networkService = NetWorkService()
    weak var delegate: SchoolDetailViewModelDelegate?
    
    var schoolName: String {
        self.school.schoolName ?? ""
    }
    
    var numOfRows: Int {
        return 4
    }
    
    private var satResult: SATResult?

    init(with school: School) {
        self.school = school
        self.fetchSatResult()
    }

    func fetchSatResult() {
        guard let dbn = self.school.dbn else {
            return
        }
        self.networkService.getSatResult(for: dbn) {[weak self] result in
            switch result {
            case .success(let satResult):
                self?.satResult = satResult.first
            case .failure(let _): ()
            }
            self?.delegate?.reload()
        }
    }
    
    var readingAvgScore:String {
        if let readingAvgScore = self.satResult?.readingAvgScore {
            return Self.averageSATReadingScoreText + readingAvgScore
        } else {
            return Self.noSATScoreInfomationText
        }
    }
    
    var isMathAvgScoreAvailable:Bool {
        self.satResult?.mathAvgScore != nil
    }
    
    var mathAvgScore:String? {
        self.satResult?.mathAvgScore
    }
    
    var writingAvgScore: String? {
        self.satResult?.writingAvgScore
    }
    
    var isWritingAvgScoreAvailable:Bool {
        self.satResult?.mathAvgScore != nil
    }
    
    var overView:String? {
        self.school.overview
    }
    
    var address: String {
        if let schoolAddress = school.location {
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
    var phone: String {
        if let phone = school.phoneNumber {
            return  "Tel:  " + phone
        }
        return ""
    }
    
    var website: String? {
        self.school.website
    }
    
    var coordiantes:CLLocationCoordinate2D? {
        guard let schoolAddress = self.school.location,
             let coordinateString = schoolAddress.slice(from: "(", to: ")") else {
            return nil
        }
        let coordinateArray = coordinateString.components(separatedBy: ",")
        let latitude = (coordinateArray[0] as NSString).doubleValue
        let longitude = (coordinateArray[1] as NSString).doubleValue
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
    }
}

extension SchoolDetailViewModel {
    struct CellIdentifiers {
        static let schoolWithSATScoreCellIdentifier =  "SchoolSATScoresTableViewCell"
        static let schoolOverviewCellIdentifier = "SchoolOverViewTableViewCell"
        static let schoolWithAddressCellIdentifier = "SchoolAddressTableViewCell"
        static let schoolWithContactCellIdentifier = "SchoolContactTableViewCell"
    }
    static let noSATScoreInfomationText = "There is no SAT score information for this high school"
    static let averageSATReadingScoreText = "SAT Average Critical Reading Score:  "
    static let averageSATMathScoreText = "SAT Average Math Score:   "
    static let averageSATWritingScoreText = "SAT Average Writing Score:   "
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
