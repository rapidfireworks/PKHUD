//
//  PKHUDCheckmarkView.swift
//  PKHUD
//
//  Created by Philip Kluz on 9/27/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

import UIKit

/// PKHUDCheckmarkView provides an animated success (checkmark) view.
open class PKHUDSuccessView: PKHUDSquareBaseView, PKHUDAnimating {

    var checkmarkShapeLayer: CAShapeLayer = {
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: 2, y: 13.5))
        checkmarkPath.addLine(to: CGPoint(x: 17, y: 28))
        checkmarkPath.addLine(to: CGPoint(x: 44, y: 0.0))

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 1.5, y: 1.5, width: 44, height: 28)
        layer.path = checkmarkPath.cgPath

        #if swift(>=4.2)
        layer.fillMode    = .forwards
        layer.lineCap     = .round
        layer.lineJoin    = .round
        #else
        layer.fillMode    = kCAFillModeForwards
        layer.lineCap     = kCALineCapRound
        layer.lineJoin    = kCALineJoinRound
        #endif

        layer.fillColor   = nil
        layer.strokeColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).cgColor
        layer.lineWidth   = 3
        return layer
    }()

    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(title: title, subtitle: subtitle)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }

    open func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.35

        checkmarkShapeLayer.add(checkmarkStrokeAnimation, forKey: "checkmarkStrokeAnim")
    }

    open func stopAnimation() {
        checkmarkShapeLayer.removeAnimation(forKey: "checkmarkStrokeAnimation")
    }
}
