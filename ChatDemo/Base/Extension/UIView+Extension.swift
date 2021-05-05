//
//  UIView+Extension.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Properties
extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    enum WithinPostion {
        case Up
        case Down
        case Left
        case Right
    }
    
    var partOne : CGRect {
        get {
            return CGRect(x: 0, y: 0, width: self.bounds.width/2, height: self.bounds.height/2)
        }
    }
    
    var partTwo : CGRect {
        get {
            return CGRect(x: self.bounds.width/2, y: 0, width: self.bounds.width/2, height: self.bounds.height/2)
        }
    }
    
    var partThree : CGRect {
        get {
            return CGRect(x: 0, y: self.bounds.height/2, width: self.bounds.width/2, height: self.bounds.height/2)
        }
    }
    
    var partFour : CGRect {
        get {
            return CGRect(x: self.bounds.width/2, y: self.bounds.height/2, width: self.bounds.width/2, height: self.bounds.height/2)
        }
    }
    
    func setShadowWithCornerRadius(corners : CGFloat, offset: CGSize){
        self.layer.cornerRadius = corners
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = 0.5
    }
    
    func createShadow(scale: Bool = true, color shadowColor: UIColor = UIColor.lightGray, radius: CGFloat = 5.0) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable var RMPborderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var RMPborderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var RMPcornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            //            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// SwifterSwift: Height of view.
    var RMPheight: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// SwifterSwift: Check if view is in RTL format.
    var RMPisRightToLeft: Bool {
        if #available(iOS 10.0, *, tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }
    
    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var RMPshadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var RMPshadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var RMPshadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var RMPshadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// SwifterSwift: Size of view.
    var RMPsize: CGSize {
        get {
            return frame.size
        }
        set {
            RMPwidth = newValue.width
            RMPheight = newValue.height
        }
    }
    
    /// SwifterSwift: Get view's parent view controller
//    var parentViewController: UIViewController? {
//        weak var parentResponder: UIResponder? = self
//        while parentResponder != nil {
//            parentResponder = parentResponder!.next
//            if let viewController = parentResponder as? BaseViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
    
    /// SwifterSwift: Width of view.
    var RMPwidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// SwifterSwift: x origin of view.
    var RMPx: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// SwifterSwift: y origin of view.
    var RMPy: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
}

extension UIView {
    
    @discardableResult
    func addHeightConstraint(_ constant: CGFloat,
                             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant
        )
        addConstraint(constraint)
        
        return constraint
        
    }
    
    @discardableResult
    func addWidthConstraint(_ constant: CGFloat,
                            relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant
        )
        addConstraint(constraint)
        
        return constraint
        
    }
    
    @discardableResult
    func addSizeRatioConstraint( _ ratio: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: ratio, constant: 0
        )
        addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func centerXAxisToSuperView(_ constant: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: superview,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        superview.addConstraint(constraint)
        
        return constraint
        
    }
    
    @discardableResult
    func centerYAxisToSuperView(_ constant: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: superview,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func centerToSuperView(_ horizontalConstant: CGFloat = 0, _ verticalConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        guard
            let a = centerXAxisToSuperView(horizontalConstant),
            let b = centerYAxisToSuperView(verticalConstant) else { return [] }
        return [a, b]
    }
    
    @discardableResult
    func stickEdgesToSuperView(edges: [NSLayoutConstraint.Attribute] = [.leading, .trailing, .top, .bottom],
                               spaces: [CGFloat] = [0.0, 0.0, 0.0, 0.0]) -> [NSLayoutConstraint] {
        guard let superview = superview, edges.count <= spaces.count else { return [] }
        
        var constraints: [NSLayoutConstraint] = []
        for (index, edge) in edges.enumerated() {
            switch edge {
            case .top, .topMargin, .leading, .leadingMargin:
                let constraint = NSLayoutConstraint(
                    item: self,
                    attribute: edge,
                    relatedBy: .equal,
                    toItem: superview,
                    attribute: edge,
                    multiplier: 1.0,
                    constant: spaces[index]
                )
                superview.addConstraint(constraint)
                constraints.append(constraint)
            case .bottom, .bottomMargin, .trailing, .trailingMargin:
                let constraint = NSLayoutConstraint(
                    item: superview,
                    attribute: edge,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: edge,
                    multiplier: 1.0,
                    constant: spaces[index]
                )
                superview.addConstraint(constraint)
                constraints.append(constraint)
            default:
                break
            }
        }
        
        return constraints
    }
    
    @discardableResult
    func stickToTopView(topView: UIView,
                        relation: NSLayoutConstraint.Relation = .equal,
                        space: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: relation,
            toItem: topView,
            attribute: topView == superview ? .top : .bottom,
            multiplier: 1.0,
            constant: space)
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func stickToBottomView(bottomView: UIView,
                           relation: NSLayoutConstraint.Relation = .equal,
                           space: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: bottomView,
            attribute: bottomView == superview ? .bottom : .top,
            relatedBy: relation,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: space)
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func stickToLeftView(leftView: UIView,
                         relation: NSLayoutConstraint.Relation = .equal,
                         space: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: relation,
            toItem: leftView,
            attribute: leftView == superview ? .leading : .trailing,
            multiplier: 1.0,
            constant: space)
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func stickToRightView(rightView: UIView,
                          relation: NSLayoutConstraint.Relation = .equal,
                          space: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = NSLayoutConstraint(
            item: rightView,
            attribute: rightView == superview ? .trailing : .leading,
            relatedBy: relation,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: space)
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult
    func stickToSafeLayoutGuide(edges: [NSLayoutConstraint.Attribute], useMargins: Bool = false) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        
        var guide = superview.layoutMarginsGuide
        
        if #available(iOS 11.0, *), !useMargins {
            guide = superview.safeAreaLayoutGuide
        }
        
        var constraints: [NSLayoutConstraint] = []
        for edge in edges {
            var anchor: NSObject?
            var guideAnchor: NSObject?
            
            switch edge {
            case .top:
                anchor = topAnchor
                guideAnchor = guide.topAnchor
            case .bottom:
                anchor = bottomAnchor
                guideAnchor = guide.bottomAnchor
            case .leading:
                anchor = leadingAnchor
                guideAnchor = guide.leadingAnchor
            case .trailing:
                anchor = trailingAnchor
                guideAnchor = guide.trailingAnchor
            default:
                break
            }
            
            guard case .some = anchor, case .some = guideAnchor else { return [] }
            
            if let vanchor = (anchor as? NSLayoutYAxisAnchor), let vguideAnchor = (guideAnchor as? NSLayoutYAxisAnchor) {
                let constraint = vanchor.constraint(equalTo: vguideAnchor)
                constraints.append(constraint)
                superview.addConstraint(constraint)
            } else if let hanchor = (anchor as? NSLayoutXAxisAnchor), let hguideAnchor = (guideAnchor as? NSLayoutXAxisAnchor) {
                let constraint = hanchor.constraint(equalTo: hguideAnchor)
                constraints.append(constraint)
                superview.addConstraint(constraint)
            }
        }
        
        return constraints
    }
}

extension UIView {
    
    func performSpringAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            view.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            
            //reducing the size
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
            
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        var image: UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    func takeSnapShotWithoutScreenUpdate() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        var image: UIImage?
        if self.drawHierarchy(in: bounds, afterScreenUpdates: false) {
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
