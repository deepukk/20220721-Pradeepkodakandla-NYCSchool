//
//  SchoolsViewModel.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla  on 7/18/22.
//

import Foundation

protocol ScchoolsViewModelDelegate {
    func reload()
}

class SchoolsViewModel {
    let service = NetWorkService()
    var dataSource: [SchoolViewModel] = []
    var schl:School? = nil
    var delegate: ScchoolsViewModelDelegate?
    
    var schoolName: String {
        return schl?.schoolName ?? ""
    }
    
    var location: String {
        if let add = schl?.address1,
            let city = schl?.city,
            let state = schl?.state,
            let zip = schl?.zip {
            return add + "," + city + "," + state + " " + zip
        }
        return ""
    }
    
    var grades: String {
        return schl?.finalGrades ?? ""
    }
    
    var totalStudents: String {
        if let totalStd = schl?.totalStudents {
            return totalStd + " students"
        }
        return ""
    }
    
    var subtitle: String {
        if let grades = schl?.finalGrades,
            let students = schl?.totalStudents {
            return grades + " | " + students + " students"
        }
        return ""
    }
    
    var numOfRows: Int {
        return dataSource.count
    }
    var numOfSections: Int {
        return 1
    }

    func school(at index: Int) -> SchoolViewModel {
        dataSource[index]
    }
    
    func getAllSchoolsList() {
        service.fetchAllSchools(completion: { (result) in
            switch result {
            case .success(let schools):
                for each in schools {
                    self.dataSource.append(SchoolViewModel(with: each))
                }
                self.delegate?.reload()
            case .failure(let _):
                self.delegate?.reload()
            }
        })
    }
}
