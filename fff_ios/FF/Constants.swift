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
    static let height:CGFloat = UIScreen.main.bounds.height
}

struct Colors {
    static let background = UIColor(rgb: 0xFFF5E2)
    static let fb = UIColor(rgb: 0x3E68C1)
    static let fbDown = fb.darker(by: 20)
    
    static let reg = UIColor.white
    static let regDown = reg.darker(by: 20)
}

struct LoginVC {
    static let buttonFont = UIFont.systemFont(ofSize: 20.0)
}

struct MessagesList {
    static let hPadding:CGFloat = 20
    static let padding:CGFloat = 15
}

struct Bubble {
    static let font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
    
    static let bubbleLength:CGFloat = 250
    static let vPadding:CGFloat = 6
    static let hPadding:CGFloat = 10
    
    static let incomingTextColor = UIColor(rgb: 0x101010)
    static let outgoingTextColor = UIColor(rgb: 0xFFFFFF)
    static let incomingColor = UIColor(rgb: 0xCACACA)
    static let outgoingColor = UIColor(rgb: 0xef9425)
    
    static let offset:CGFloat = Dimensions.width - 2 * MessagesList.padding
    
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






