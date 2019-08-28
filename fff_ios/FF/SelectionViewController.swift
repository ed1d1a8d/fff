//
//  SelectionViewController.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    let titleLabel = FLabel(text: "I want to eat with",
                           font: UIFont.systemFont(ofSize: 32, weight: .medium),
                           color: UIColor.black)
    let selectionToggle = SelectionToggle()
    let timeLabel = FLabel(text: "within the next",
                            font: UIFont.systemFont(ofSize: 32, weight: .medium),
                            color: UIColor.black)
    let selectionSlider = SelectionSlider()
    let selectionTime = SelectionTime()
    
    let friendButton = SButton(titleText: "Find friends!",
                               font: UIFont.systemFont(ofSize: 24))

    let container = FView(baseColor: UIColor.white)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
        
        self.selectionSlider.addTarget(self, action: #selector(SelectionViewController.sliderChanged), for: .valueChanged)
        self.friendButton.addTarget(self, action: #selector(SelectionViewController.showMapView), for: .touchUpInside)
        
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.selectionToggle)
        self.container.addSubview(self.timeLabel)
        
        self.container.addSubview(self.selectionSlider)
        self.container.addSubview(self.selectionTime)
        self.container.addSubview(self.friendButton)
        
        self.view.addSubview(self.container)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .top, .right], padding: 0))
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.selectionToggle, spacing: 25))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.selectionToggle, sides: [.left, .right], padding: 0))
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.selectionToggle, lowerView: self.timeLabel, spacing: 25))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.timeLabel, sides: [.left, .right], padding: 0))
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.timeLabel, lowerView: self.selectionSlider, spacing: 25))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.selectionSlider, sides: [.left, .right], padding: 10))

        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.selectionSlider, lowerView: self.selectionTime, spacing: 25))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.selectionTime, sides: [.left, .right], padding: 0))
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.selectionTime, lowerView: self.friendButton, spacing: 25))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendButton, sides: [.left, .bottom, .right], padding: 0))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .right], padding: 50))
        self.view.addConstraints(FConstraint.centerAlignConstraints(firstView: self.container, secondView: self.view))
    }
    
    @objc func sliderChanged(sender: UISlider) {
        print(sender.value)
        selectionTime.updateTime(time: sender.value)
    }
    
    @objc func showMapView() {
        let mapView = MapViewController()
        self.present(mapView, animated: true, completion: nil)
    }
}





