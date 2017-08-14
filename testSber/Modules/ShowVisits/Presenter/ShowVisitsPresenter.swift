//
//  ShowVisitsPresenter.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation
import MapKit

class ShowVisitsPresenter: NSObject, ShowVisitsPresenterInput, ShowVisitsPresenterOutput {
    
    var showVisitsInteractor: ShowVisitsInteractor?
    var showVisitsViewController: ShowVisitsViewController?
    
    var visits = [Visit]()
    var annotationsDict = [String: MKAnnotation]()
    
    var dontNeedSelectTable = false
    
    
//MARK: - Show Visits Presenter Input
    func updateView() {
        showVisitsInteractor?.getOrganizationsAndVisits()
    }
    
    func indexPathRowSelected(indexPath: IndexPath) -> (isNeedSelect: Bool, annotation: MKAnnotation?) {
        let visit = visits[indexPath.row]
        
        if let orgId = visit.organizationId, annotationsDict[orgId] != nil {
            dontNeedSelectTable = true
            
            return (true, annotationsDict[orgId])
        }
        
        return (false, nil)
    }
    
    func indexPathToActionRow(annotation: MKAnnotation, isSelect: Bool) -> IndexPath? {
        if (!dontNeedSelectTable || !isSelect) && visits.count > 0 {
            if let keys = (annotationsDict as NSDictionary).allKeys(for: annotation) as? [String] {
                for i in 0..<visits.count {
                    let visit = visits[i]
                    
                    if let id = visit.organizationId, keys.contains(id) {
                        return IndexPath(row: i, section: 0)
                    }
                }
            }
        }
        
        if isSelect {
            dontNeedSelectTable = false
        }
        
        return nil
    }
    
    
//MARK: - Show Visits Presenter Output
    func dataFetched(visitsArr: [Visit]) {
        visits = visitsArr
        
        annotationsDict = [String: MKAnnotation]()
        
        for visit in visits {
            if let org = visit.organization, annotationsDict[org.organizationId] == nil {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: org.latitude, longitude: org.longitude)
                annotation.title = org.title
                
                annotationsDict[visit.organizationId!] = annotation
            }
        }
        
        showVisitsViewController?.showOrganizations()
    }
}
