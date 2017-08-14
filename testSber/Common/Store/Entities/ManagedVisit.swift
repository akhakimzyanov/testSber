//
//  ManagedVisit.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedVisit)
class ManagedVisit: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var organizationId: String?
    @NSManaged var organization: ManagedOrganization?
}
