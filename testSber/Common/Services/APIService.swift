//
//  APIService.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation

class APIService {
    
    private let requestBuilder: RequestBuilder
    private let requestExecutor: RequestExecutor
    

//MARK: - Init
    init() {
        requestBuilder = RequestBuilder()
        requestExecutor = RequestExecutor()
    }
    

//MARK: - Work Methods
    func getOrganizations(completion: @escaping (_ json: [[String: Any]]?) -> Void) {
        if let request = requestBuilder.organizations() {
            requestExecutor.makeRequest(request: request, completion: { json in
                completion(json as? [[String: Any]])
            })
            
            return
        }
    
        completion(nil)
    }
    
    func getVisits(completion: @escaping (_ json: [[String: Any]]?) -> Void) {
        if let request = requestBuilder.visits() {
            requestExecutor.makeRequest(request: request, completion: { json in
                completion(json as? [[String: Any]])
            })
            
            return
        }
        
        completion(nil)
    }
}
