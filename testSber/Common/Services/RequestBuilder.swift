//
//  RequestBuilder.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation

class RequestBuilder {
    
    private let rootPath = "http://demo3526062.mockable.io/"
    
    
//MARK: - Requests
    func organizations() -> URLRequest? {
        let urlStr = rootPath + "getOrganizationListTest"
        
        return getRequest(urlStr: urlStr)
    }
    
    func visits() -> URLRequest? {
        let urlStr = rootPath + "getVisitsListTest"
        
        return getRequest(urlStr: urlStr)
    }
    
    private func getRequest(urlStr: String) -> URLRequest? {
        if let url = URL(string: urlStr) {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
