//
//  ShowVisitsViewController.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShowVisitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowVisitsViewControllerProtocol, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var visitsTable: UITableView!
    
    var showVisitsPresenter: ShowVisitsPresenter?
    
    
//MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showVisitsPresenter?.updateView()
        
        let startCoord = CLLocationCoordinate2DMake(55.75, 37.62)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 30000, 30000))
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
//MARK: - Update Methods
    func showOrganizations() {
        DispatchQueue.main.async {
            self.visitsTable.reloadData()
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            for (_, annotation) in self.showVisitsPresenter?.annotationsDict ?? [String: MKAnnotation]() {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
//MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showVisitsPresenter?.visits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell") as? ShowVisitsTableViewCell
        
        if let organization = showVisitsPresenter?.visits[indexPath.row] {
            cell?.titleLabel.text = organization.title
            cell?.organizationLabel.text = organization.organization?.title
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let response = showVisitsPresenter?.indexPathRowSelected(indexPath: indexPath)
        
        if let resp = response, let annotation = resp.annotation, resp.isNeedSelect {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    
//MARK: - Map View Methods
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view as? MKPinAnnotationView {
            annotation.pinTintColor = UIColor.blue
            
            if let annotation = view.annotation, let indexPath = self.showVisitsPresenter?.indexPathToActionRow(annotation: annotation, isSelect: true) {
                visitsTable.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let annotation = view as? MKPinAnnotationView {
            annotation.pinTintColor = UIColor.red
            
            if let annotation = view.annotation, let indexPath = self.showVisitsPresenter?.indexPathToActionRow(annotation: annotation, isSelect: false) {
                visitsTable.deselectRow(at: indexPath, animated: false)
            }
        }
    }
}
