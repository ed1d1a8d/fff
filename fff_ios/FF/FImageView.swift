//
//  FImageView.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FImageView: UIImageView {
    
    init(name: String, height: CGFloat) {
        let img = UIImage(named: name)
        super.init(image: img)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        
        addConstraints(height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints(height: CGFloat) {
        let aspectRatio = self.image!.size.width / self.image!.size.height
        self.addConstraint(FConstraint.aspectRatioConstraint(view: self, aspectRatio: aspectRatio))
        
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: height))
    }
    
}
