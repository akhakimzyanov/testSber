//
//  ManagedOrganization.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedOrganization)
class ManagedOrganization: NSManagedObject {
    
    @NSManaged var organizationId: String
    @NSManaged var title: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var visits: NSSet?
}
