//
//  School.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation

struct School: Codable {
    let dbn: String?
    let schoolName:String?
    let overview:String?
    let address1:String?
    let city:String?
    let state:String?
    let zip:String?
    let phoneNumber:String?
    let faxNumber:String?
    let schoolEmail:String?
    let website:String?
    let finalGrades:String?
    let totalStudents:String?
    let latitude:String?
    let longitude:String?
    let subway: String?
    let bus: String?
    enum CodingKeys : String, CodingKey {
        case schoolName         = "school_name"
        case overview           = "overview_paragraph"
        case phoneNumber        = "phone_number"
        case faxNumber          = "fax_number"
        case schoolEmail        = "school_email"
        case finalGrades        = "finalgrades"
        case totalStudents      = "total_students"
        case address1           = "primary_address_line_1"
        case state              = "state_code"
        case dbn,website,latitude,longitude,zip,city,subway,bus
    }
}
