//
//  OnboardingDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

struct PageControlData {
    
    let currentPage: Int
    let numberOfPages: Int
}

class OnboardingDetailViewModel: ViewModelType {

    let image: UIImage?
    let title: String
    let summary: String
    let pageControlData: PageControlData
    fileprivate let analyticsNavigationType: AnalyticsNavigationType

    var delegate: ViewModelDelegate?
    
    init(image: UIImage?, title: String, summary: String, pageControlData: PageControlData, analyticsNavigationType: AnalyticsNavigationType) {
        self.image = image
        self.title = title
        self.summary = summary
        self.pageControlData = pageControlData
        self.analyticsNavigationType = analyticsNavigationType
    }
    
    func bootstrap() {
        self.delegate?.willLoadData()
        self.delegate?.didLoadData()
    }
    
    func trackNavigation() {
        
        AppAnalytics.logNavigation(navigation: self.analyticsNavigationType)
    }
}
