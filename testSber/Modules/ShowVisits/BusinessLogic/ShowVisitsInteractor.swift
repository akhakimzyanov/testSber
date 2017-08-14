//
//  ShowVisitsInteractor.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit

class ShowVisitsInteractor: NSObject, ShowVisitsInteractorProtocol {
    
    var dataManager: ShowVisitsDataManager?
    var apiService: APIService?
    
    var showVisitsPresenter: ShowVisitsPresenter?

    
//MARK: - Show Visits Interactor Protocol
    func getOrganizationsAndVisits() {
        self.dataManager?.getVisits(completion: { [weak self] visits in
            self?.showVisitsPresenter?.dataFetched(visitsArr: visits)
        })
        
        let semaphore = DispatchSemaphore(value: 1)
        
        DispatchQueue.global().async {
            semaphore.wait()
            
            self.apiService?.getOrganizations(completion: { [weak self] organizations in
                if let organizationArr = organizations {
                    self?.dataManager?.saveOrganizations(organizationArr)
                }
                
                semaphore.signal()
            })
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            
            self.apiService?.getVisits(completion: { [weak self] visits in
                if let visitsArr = visits {
                    self?.dataManager?.saveVisits(visitsArr)
                    
                    self?.dataManager?.getVisits(completion: { visits in
                        self?.showVisitsPresenter?.dataFetched(visitsArr: visits)
                    })
                }
                
                semaphore.signal()
            })
        }
    }
}
