//
//  OnboardingDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class OnboardingDetailViewModel: ViewModelType {

    let image: UIImage?
    let title: String
    let summary: String
    fileprivate let analyticsNavigationType: AnalyticsNavigationType

    var delegate: ViewModelDelegate?
    
    init(image: UIImage?, title: String, summary: String, analyticsNavigationType: AnalyticsNavigationType) {
        self.image = image
        self.title = title
        self.summary = summary
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
