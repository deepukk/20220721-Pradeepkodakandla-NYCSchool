//
//  SchoolsViewModel.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla  on 7/18/22.
//

import Foundation

class SchoolsViewModel {
    let service = NetWorkService()
    var dataSource: [School]?
    var schl:School? = nil
    
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
        return dataSource?.count ?? 0
    }
    var numOfSections: Int {
        return 1
    }

    func data(at index: Int) {
        if let item = dataSource?[index] {
            schl = item
        }
    }
    
    func getAllSchoolsList(completion: @escaping (Error?) -> Void) {
        service.fetchAllSchools(completion: { (result) in
            switch result {
            case .success(let schools):
                self.dataSource = schools
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }

}
