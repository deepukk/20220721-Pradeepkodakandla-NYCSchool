//
//  NetWorkService.swift
//  NYCSChools
//
//  Created by Pradeep Kodakandla on 7/18/22.
//

import Foundation
import UIKit

class NetWorkService {
    private let _defaultSession = URLSession(configuration: .default)
    private var _dataTask: URLSessionDataTask?
    
    // Get All schools info from api call
    func fetchAllSchools(completion: @escaping((Result<[School]>) -> Void)) {
        guard let schoolsUrl = URL(string: API.schoolsUrl) else {
            return
        }
        
        let request = URLRequest(url: schoolsUrl)
        
        _dataTask = _defaultSession.dataTask(with: request,
                                             completionHandler: { (data, response, error) in
                                                defer { self._dataTask = nil }
            let result = self.processSchoolsListRequest(data: data, error: error)
                                                OperationQueue.main.addOperation {
                                                    completion(result)
                                                }
        })
        _dataTask?.resume()
    }
    
    // Process all schools information from response
    func processSchoolsListRequest( data: Data?,
                                error: Swift.Error?) -> Result<[School]> {
        
        if let error = error {
            return .failure(Error.requestFailed(reason: error.localizedDescription))
        }
        
        guard let data = data else {
            return .failure(Error.noData)
        }
        let decoder = JSONDecoder()
        do {
            let schools = try decoder.decode([School].self, from: data)
            return .success(schools)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
    }
    
    // Get SAT results from api call by passing #DBN
    func getSatResult(for dbn: String ,
                        completion: @escaping((Result<[SATResult]>) -> Void)) {
        let urlString = API.satResultUrl + dbn
        guard let satResultUrl = URL(string: urlString) else {
            return
        }
        print(satResultUrl)
        
        var request = URLRequest(url: satResultUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let dataTask = _defaultSession.dataTask(with: request,
                                             completionHandler: { (data, response, error) in
            let result = self.processSatResultRequest(data: data, error: error)
                                                OperationQueue.main.addOperation {
                                                    completion(result)
                                                }
        })
        dataTask.resume()
    }
    
    // Process SATResults from API response
    func processSatResultRequest( data: Data?,
                              error: Swift.Error?) -> Result<[SATResult]> {
        if let error = error {
            return .failure(Error.requestFailed(reason: error.localizedDescription))
        }
        guard let data = data else {
            return .failure(Error.noData)
        }
        let decoder = JSONDecoder()
        do {
            let user = try JSONSerialization.jsonObject(with: data, options: [])
            print(user)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
        do {
            let satResult = try decoder.decode([SATResult].self, from: data)
            return .success(satResult)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
    }

}

// MARK: - Error Definitions
extension NetWorkService {
    
    enum Error: Swift.Error {
        case noData
        case jsonSerializationFailed(reason: String)
        case requestFailed(reason: String)
    }
}

extension NetWorkService.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data returned with response"
        case .jsonSerializationFailed(let reason):
            return reason
        case .requestFailed(let reason):
            return reason
        }
    }
}

extension NetWorkService {
    struct API {
        static let schoolsUrl       = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        static let satResultUrl     = "https://data.cityofnewyork.us/resource/f9bf-2cp4?dbn="

    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
