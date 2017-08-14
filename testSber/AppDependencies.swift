//
//  AppDependencies.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit

class AppDependencies: NSObject {

    private let showVisitsWireframe = ShowVisitsWireframe()
    
    
//MARK: - Init
    override init() {
        let showVisitsDataManager = ShowVisitsDataManager()
        showVisitsDataManager.coreDataManager = CoreDataManager()
        
        let showVisitsViewController = showVisitsWireframe.showVisitsViewController
        let showVisitsPresenter = ShowVisitsPresenter()
        let showVisitsInteractor = ShowVisitsInteractor()
        
        showVisitsViewController?.showVisitsPresenter = showVisitsPresenter
        
        showVisitsPresenter.showVisitsInteractor = showVisitsInteractor
        showVisitsPresenter.showVisitsViewController = showVisitsViewController
        
        showVisitsInteractor.dataManager = showVisitsDataManager
        showVisitsInteractor.apiService = APIService()
        showVisitsInteractor.showVisitsPresenter = showVisitsPresenter
    }
    
    func application(didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: UIWindow) -> Bool {
        showVisitsWireframe.presentShowVisitsViewControllerInWindow(window)
        
        return true
    }
}
