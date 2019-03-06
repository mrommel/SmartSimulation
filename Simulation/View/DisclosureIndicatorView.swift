//
//  DisclosureIndicatorView.swift
//  Simulation
//
//  Created by Michael Rommel on 05.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class DisclosureIndicatorView: UIView {
    
    @IBInspectable var color = UIColor.black {
        didSet {
            self.backgroundColor = .clear
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 3
        let y = self.bounds.midY
        let R = CGFloat(4.5)
        context?.move(to: CGPoint(x: x - R, y: y - R))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R, y: y + R))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(2)
        color.setStroke()
        context?.strokePath()
    }
}
