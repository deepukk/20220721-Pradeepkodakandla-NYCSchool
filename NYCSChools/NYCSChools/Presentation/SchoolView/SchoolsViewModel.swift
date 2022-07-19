//
//  SchoolsViewModel.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla  on 7/18/22.
//

import Foundation

protocol ScchoolsViewModelDelegate: AnyObject {
    func reload()
}

class SchoolsViewModel {
    let service = NetWorkService()
    var dataSource: [SchoolViewModel] = []
    var selectedSchoolViewModel:SchoolViewModel? = nil
    weak var delegate: ScchoolsViewModelDelegate?
        
    var numOfRows: Int {
        return dataSource.count
    }
    var numOfSections: Int {
        return 1
    }

    func school(at index: Int) -> SchoolViewModel {
        dataSource[index]
    }
    
    func selectedSchoolDetailViewModel() -> SchoolDetailViewModel? {
        guard let schoolModel = self.selectedSchoolViewModel else {
            return nil
        }
        let detailViewModel = SchoolDetailViewModel(with: schoolModel.school)
        return detailViewModel
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

