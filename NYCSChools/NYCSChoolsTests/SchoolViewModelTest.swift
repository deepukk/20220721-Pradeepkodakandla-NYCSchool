//
//  SchoolViewModelTest.swift
//  NYCSChoolsTests
//
//  Created by Pradeep Kodakandla on 7/21/22.
//

import Foundation
import XCTest
@testable import NYCSChools

class SchoolViewModelTest: XCTestCase {
    
    var schoolVm: SchoolsViewModel?
    
    override func setUp() {
        schoolVm = SchoolsViewModel()
        let schools = MockSchoolData.getMaockSchoolData() ?? []
        for each in schools {
            schoolVm?.dataSource.append(SchoolViewModel(with:each))
        }
        schoolVm?.selectedSchoolViewModel = schoolVm?.dataSource.first
    }
    
    func testSchoolName() {
        if let schoolName = schoolVm?.selectedSchoolViewModel?.school.schoolName {
            XCTAssertEqual(schoolName, "Clinton School Writers & Artists, M.S. 260")
        }
    }
    
    func testlocation() {
        XCTAssertNil(schoolVm?.selectedSchoolViewModel?.school.location)
    }
    
    func testTotalStudents() {
        if let totalStudents = schoolVm?.selectedSchoolViewModel?.school.totalStudents {
            XCTAssertEqual(totalStudents, "376 students")
        }
    }
        
    func testNumOfRows() {
        XCTAssertNotNil(schoolVm?.numOfRows)
    }
    func testNumOfSections() {
        XCTAssertNotNil(schoolVm?.numOfSections)
    }
}

