//
//  ButtonExtension.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/19/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

extension UIButton {
    
    func likeShake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.7
        animation.values = [-20.0, 20.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func dislikeShake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.7
        animation.values = [-20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
