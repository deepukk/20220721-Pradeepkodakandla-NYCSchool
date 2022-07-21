//
//  MockSchoolData.swift
//  NYCSChoolsTests
//
//  Created by Pradeep Kodakandla on 7/21/22.
//

import Foundation
import XCTest
@testable import NYCSChools

class MockSchoolData: NSObject {
    
    class func getMaockSchoolData() -> [School]? {
        let data = loadtestDataFromFile()
        return decodeJsonData(data: data) ?? nil
    }
    
    class func loadtestDataFromFile() -> Data {
        guard let path = Bundle.main.path(forResource: "testSchoolData", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return data
    }
    class func decodeJsonData(data: Data) -> [School]? {
        let decoder = JSONDecoder()
        
        do {
            let schools = try decoder.decode([School].self, from: data)
            return schools
            
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch {
            print("reason: Failed to convert data to JSON")
        }
        return nil
    }
}

class MockSATData: NSObject {
    class func getMockSATData() -> [SATResult]? {
        let data = loadtestDataFromFile()
        return decodeJsonData(data: data) ?? nil
    }
    
    class func loadtestDataFromFile() -> Data {
        guard let path = Bundle.main.path(forResource: "satData", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return data
    }
    class func decodeJsonData(data: Data) -> [SATResult]? {
        let decoder = JSONDecoder()
        
        do {
            let schools = try decoder.decode([SATResult].self, from: data)
            return schools
            
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch {
            print("reason: Failed to convert data to JSON")
        }
        return nil
    }
}


