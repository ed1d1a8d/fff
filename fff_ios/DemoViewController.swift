//
//  DemoViewController.swift
//  
//
//  Created by Stella Yang on 8/30/19.
//

import UIKit

class DemoViewController: UIViewController {
    
    let container = FView(baseColor: UIColor.yellow)
    let demo1 = FView(baseColor: UIColor.green)
    let demo2 = FView(baseColor: UIColor.magenta)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        self.container.addSubview(self.demo1)
        self.container.addSubview(self.demo2)
        self.view.addSubview(self.container)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.centerAlignConstraints(firstView: self.container, secondView: self.view))
        self.view.addConstraint(FConstraint.fillXConstraints(view: self.container, widthRatio: 0.6))
        self.view.addConstraint(FConstraint.fillYConstraints(view: self.container, heightRatio: 0.3))
        
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.demo1, sides: [.left, .top, .right], padding: 0))
        self.container.addConstraint(FConstraint.fillYConstraints(view: self.demo1, heightRatio: 0.40))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.demo2, sides: [.left, .bottom, .right], padding: 0))
        self.container.addConstraint(FConstraint.fillYConstraints(view: self.demo2, heightRatio: 0.40))

    }
    
    
}
