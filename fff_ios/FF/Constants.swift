//
//  Constants.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

struct Dimensions {
    static let statusHeight:CGFloat = 20
    static let contactsWidth:CGFloat = UIScreen.main.bounds.width - (30 + 10)
    
    static let width:CGFloat = UIScreen.main.bounds.width
}

struct MessagesList {
    static let hPadding:CGFloat = 20
}

struct Bubble {
    static let font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
    
    static let bubbleLength:CGFloat = 250
    static let vPadding:CGFloat = 6
    static let hPadding:CGFloat = 10
    
    static let offset:CGFloat = Dimensions.width
    
    static let cushion:CGFloat = 0.5
    
    static let cornerRadius:CGFloat = (hPadding * 2 + heightForUILabel(text: "Testing", font: font, width: bubbleLength)) * 0.35
}

struct Keyboard {
    static let correctionType = UITextAutocorrectionType.no
    static let appearance = UIKeyboardAppearance.alert

    static let font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    static let defaultHeight = font.lineHeight
    
    static let tintColor = UIColor.magenta
    
    static let placeholder = "Type a message..."
    static let placeholderColor = UIColor.gray
    
    static let maxLines = 8
    static let maxHeight:CGFloat = font.lineHeight * CGFloat(maxLines)
    
    struct SendButton {
        static let color = UIColor.magenta
        static let diameter = defaultHeight * 1.75
        
        static let icon = UIImage(named: "sendIcon")!
        static let iconPadding:CGFloat = diameter * 0.22
        static let buttonpadding = defaultHeight * 0.75
    }
    

}






