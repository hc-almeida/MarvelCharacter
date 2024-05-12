//
//  UIView+Extension.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 01/05/24.
//

import Foundation
import UIKit

extension UIView {
    
    func addBlurToView(style: UIBlurEffect.Style) {
        var blurEffect: UIBlurEffect!
        
        blurEffect = UIBlurEffect(style: style)
        
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 1
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectView)
    }
}
