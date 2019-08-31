//
//  FConstraint.swift
//  SimpleContrast
//
//  Created by Jiahao Li on 8/27/19.
//  Copyright © 2019 Jiahao Li. All rights reserved.
//

import UIKit

class FConstraint {
    
    static func fillYConstraints(view: UIView, heightRatio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view.superview!, attribute: .height, multiplier: heightRatio, constant: 0.0)
    }
    
    static func fillXConstraints(view: UIView, widthRatio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview!, attribute: .width, multiplier: widthRatio, constant: 0.0)
    }
    
    static func squareHeightConstraints(view: UIView, squareRatio: CGFloat) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view.superview, attribute: .height, multiplier: squareRatio, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .height, multiplier: squareRatio, constant: 0.0)
        ]
    }
    
    static func squareWidthConstraints(view: UIView, squareRatio: CGFloat) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: squareRatio, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: squareRatio, constant: 0.0)
        ]
    }
    
    static func centerAlignConstraints(firstView: UIView, secondView: UIView) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: firstView, attribute: .centerX, relatedBy: .equal, toItem: secondView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: firstView, attribute: .centerY, relatedBy: .equal, toItem: secondView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
        ]
    }
    
    static func verticalAlignConstraint(firstView: UIView, secondView: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .centerY, relatedBy: .equal, toItem: secondView, attribute: .centerY, multiplier: 1.0, constant: 0)
    }
    
    static func horizontalAlignConstraint(firstView: UIView, secondView: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .centerX, relatedBy: .equal, toItem: secondView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    }
    
    static func visualFormatConstraints(constraints: [String], withViewsDictionary viewsDict: [String: AnyObject]) -> [NSLayoutConstraint] {
        return constraints.map { NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: viewsDict) }.reduce([], +)
    }
    
    static func equalConstraint(firstView: UIView, secondView: UIView, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: attribute, relatedBy: .equal, toItem: secondView, attribute: attribute, multiplier: 1.0, constant: 0.0)
    }
    
    static func aspectRatioConstraint(view: UIView, aspectRatio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: aspectRatio, constant: 0.0)
    }
    
    static func constantConstraint(view: UIView, attribute: NSLayoutConstraint.Attribute, value: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: value)
    }
    
    static func lessThanOrEqualConstraint(view: UIView, attribute: NSLayoutConstraint.Attribute, value: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: value)
    }
        
    static func paddingPositionConstraint(view: UIView, side: NSLayoutConstraint.Attribute, padding: CGFloat) -> NSLayoutConstraint {
        let actualPadding = (side == .bottom || side == .right) ? -padding : padding
        
        return NSLayoutConstraint(item: view, attribute: side, relatedBy: .equal, toItem: view.superview!, attribute: side, multiplier: 1.0, constant: actualPadding)
    }
    
    static func paddingPositionConstraints(view: UIView, sides: [NSLayoutConstraint.Attribute], padding: CGFloat) -> [NSLayoutConstraint] {
        return sides.map { FConstraint.paddingPositionConstraint(view: view, side: $0, padding: padding) }
    }
    
    static func horizontalSpacingConstraint(leftView: UIView, rightView: UIView, spacing: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: leftView, attribute: .right, relatedBy: .equal, toItem: rightView, attribute: .left, multiplier: 1.0, constant: -spacing)
    }
    
    static func verticalSpacingConstraint(upperView: UIView, lowerView: UIView, spacing: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: upperView, attribute: .bottom, relatedBy: .equal, toItem: lowerView, attribute: .top, multiplier: 1.0, constant: -spacing)
    }
    
    static func horizontalStackingConstraints(views: [UIView], padding: CGFloat, spacing: CGFloat) -> [NSLayoutConstraint] {
        guard views.count > 0 else {
            return []
        }
        
        var results = [self.paddingPositionConstraint(view: views[0], side: .left, padding: padding)]
        for i in 0 ..< views.count - 1 {
            results.append(self.horizontalSpacingConstraint(leftView: views[i], rightView: views[i + 1], spacing: spacing))
            results.append(self.verticalAlignConstraint(firstView: views[i], secondView: views[i + 1]))
        }
        
        return results
    }
    
}
