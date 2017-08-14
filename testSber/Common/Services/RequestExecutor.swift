//
//  RequestExecutor.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation

class RequestExecutor {
    
    func makeRequest(request: URLRequest, completion: @escaping (_ json: Any) -> Void) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                completion(json)
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        task.resume()
    }
}
