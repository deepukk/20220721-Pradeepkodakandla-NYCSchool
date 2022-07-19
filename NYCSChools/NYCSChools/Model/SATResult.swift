//
//  SATResult.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation

struct SATResult: Codable {
    let dbn: String?
    let schoolName: String?
    let numOfTestTakers: String?
    let readingAvgScore: String?
    let mathAvgScore: String?
    let writingAvgScore: String?
    
    enum CodingKeys : String, CodingKey {
        case schoolName              = "school_name"
        case numOfTestTakers         = "num_of_sat_test_takers"
        case readingAvgScore         = "sat_critical_reading_avg_score"
        case mathAvgScore            = "sat_math_avg_score"
        case writingAvgScore         = "sat_writing_avg_score"
        case dbn
    }
}
