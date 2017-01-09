//
//  LeftPaddeTextField.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/9/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class LeftPaddeTextField: UITextField {

    /*
     Only override draw() if you perform custom drawing.
     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
         Drawing code
    }
    */

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }

}
