//
//  Extension + UIViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 07/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        // MARK: - Add blurEffect for backgraund
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        // MARK: - remove blurEffect
        guard let subViewCount = (parent?.view.subviews.count) else { return }
        
        let subView = parent?.view.subviews[subViewCount - 2]
        subView?.removeFromSuperview()
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
