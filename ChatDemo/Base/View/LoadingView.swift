//
//  LoadingView.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height

class WSLoadingView {
    
    class func show() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let containerView = UIView(frame: CGRect(x: SCREEN_WIDTH/2 - 50, y: SCREEN_HEIGHT/2 - 50, width: 100, height: 100))
        containerView.backgroundColor = .clear
        containerView.tag = 2125
        window.addSubview(containerView)
        let indicator = UIActivityIndicatorView()
        indicator.tag = 2521
        indicator.center = CGPoint(x: containerView.bounds.size.width/2, y: containerView.bounds.size.height/2)
        indicator.style = .gray
        containerView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    class func hide() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        if let viewWithTag = window.viewWithTag(2521) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = window.viewWithTag(2125) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    class func showWithMask() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        containerView.backgroundColor = .black
        containerView.alpha = 0.2
        containerView.tag = 2125
        window.addSubview(containerView)
        let indicator = UIActivityIndicatorView()
        indicator.tag = 2521
        indicator.center = CGPoint(x: containerView.bounds.size.width/2, y: containerView.bounds.size.height/2)
        indicator.style = .white
        containerView.addSubview(indicator)
        indicator.startAnimating()
    }
}
