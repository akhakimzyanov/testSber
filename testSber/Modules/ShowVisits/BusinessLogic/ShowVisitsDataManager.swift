//
//  ShowVisitsDataManager.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation

class ShowVisitsDataManager: NSObject {
    
    var coreDataManager: CoreDataManager?
    
    var queue = DispatchQueue(label: "coreDataQueue")
    
    
    
//MARK: - Get Data Methods
    func getOrganizations(completion: (([Organization]) -> Void)!) {
        queue.async { [weak self] in
            if let entries = self?.coreDataManager?.fetchOrganizationsWithPredicate(nil, sortDescriptors: []) {
                if let organizations = self?.organizationsFromDataStoreEntries(entries) {
                    completion(organizations)
                }
            }
        }
    }
    
    func getVisits(completion: (([Visit]) -> Void)!) {
        queue.async { [weak self] in
            if let entries = self?.coreDataManager?.fetchVisitsWithPredicate(nil, sortDescriptors: []) {
                if let visits = self?.visitsFromDataStoreEntries(entries) {
                    completion(visits)
                }
            }
        }
    }
    
    
//MARK: - Object Formatting Methods
    func organizationsFromDataStoreEntries(_ entries: [ManagedOrganization]) -> [Organization] {
        var organizations = [Organization]()
        
        for managedOrganization in entries {
            let organization = Organization(organizationId: managedOrganization.organizationId, title: managedOrganization.title, latitude: managedOrganization.latitude, longitude: managedOrganization.longitude)
            organizations.append(organization)
        }
        
        return organizations
    }
    
    func visitsFromDataStoreEntries(_ entries: [ManagedVisit]) -> [Visit] {
        var visits = [Visit]()
        
        for managedVisit in entries {
            var organization: Organization?
            
            if let org = managedVisit.organization {
                organization = Organization(organizationId: org.organizationId, title: org.title, latitude: org.latitude, longitude: org.longitude)
            }
            
            let visit = Visit(title: managedVisit.title, organizationId: managedVisit.organizationId, organization: organization)
            visits.append(visit)
        }
        
        return visits
    }
    
    
//MARK: - Save
    func saveOrganizations(_ entries: [[String: Any]]) {
        queue.sync { [weak self] in
            var organizations = [Organization]()
            
            for entry in entries {
                if let id = entry["organizationId"] as? String {
                    let organization = Organization(organizationId: id, title: entry["title"] as? String, latitude: entry["latitude"] as? Double ?? 0, longitude: entry["longitude"] as? Double ?? 0)
                    
                    organizations.append(organization)
                }
            }
            
            self?.coreDataManager?.saveOrganizations(organizations: organizations)
        }
    }
    
    func saveVisits(_ entries: [[String: Any]]) {
        queue.sync { [weak self] in
            var visits = [Visit]()
            
            for entry in entries {
                if let title = entry["title"] as? String {
                    let visit = Visit(title: title, organizationId: entry["organizationId"] as? String, organization: nil)
                    
                    visits.append(visit)
                }
            }
            
            self?.coreDataManager?.saveVisits(visits: visits)
        }
    }
}
