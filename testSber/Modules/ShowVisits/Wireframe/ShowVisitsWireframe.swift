//
//  ShowVisitsWireframe.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit

class ShowVisitsWireframe: NSObject, ShowVisitsWireframeProtocol {
    
    var showVisitsViewController: ShowVisitsViewController?
    
    var window: UIWindow?
    
    
//MARK: - Init
    override init() {
        super.init()
        
        showVisitsViewController = getShowVisitsViewController()
    }

    
//MARK: - Show Visits Wireframe Protocol
    func presentShowVisitsViewControllerInWindow(_ window: UIWindow) {
        self.window = window
        
        window.rootViewController = showVisitsViewController
        window.makeKeyAndVisible()
    }
    
    
//MARK: - Help Methods
    private func getShowVisitsViewController() -> ShowVisitsViewController {
        let storyboard = UIStoryboard(name: "ShowVisits", bundle: nil)
        let showVisitsVC = storyboard.instantiateViewController(withIdentifier: "ShowVisitsViewController") as! ShowVisitsViewController
        
        return showVisitsVC
    }
}
