//
//  KeyboardViewController.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    var keyboardConstraint:NSLayoutConstraint!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardViewController.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardViewController.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(KeyboardViewController.dismissKeyboard)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.keyboardConstraint.constant == 0 {
                self.keyboardConstraint.constant = -keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.keyboardConstraint.constant != 0 {
                self.keyboardConstraint.constant = 0
            }
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

