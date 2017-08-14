//
//  ShowVisitsPresenterProtocol.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation
import MapKit

protocol ShowVisitsPresenterInput {
    func updateView()
    func indexPathRowSelected(indexPath: IndexPath) -> (isNeedSelect: Bool, annotation: MKAnnotation?)
    func indexPathToActionRow(annotation: MKAnnotation, isSelect: Bool) -> IndexPath?
}

protocol ShowVisitsPresenterOutput {
    func dataFetched(visitsArr: [Visit])
}
