//
//  OnboardingDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class OnboardingDetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel: OnboardingDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = self.viewModel else {
            fatalError("viewModel must be initialized")
        }
        
        viewModel.delegate = self
        viewModel.bootstrap()
    }
}

extension OnboardingDetailViewController: ViewModelDelegate {
    
    func willLoadData() {
        // NOOP
    }
    
    func didLoadData() {
        
        self.image.image = self.viewModel?.image
        self.titleLabel.text = self.viewModel?.title
        self.summaryLabel.text = self.viewModel?.summary
    }
}
