//
//  Extensions.swift
//  Saloni
//
//  Created by Ankur Verma on 26/03/21.
//

import Foundation
import UIKit

class HorizontalView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let topRect = CGRect(x: 0, y: 0, width: rect.size.width/2, height: rect.size.height)
        UIColor.red.set()
        guard let topContext = UIGraphicsGetCurrentContext() else { return }
        topContext.fill(topRect)

        let bottomRect = CGRect(x: rect.size.width/2, y: 0, width: rect.size.width/2, height: rect.size.height)
        UIColor.green.set()
        guard let bottomContext = UIGraphicsGetCurrentContext() else { return }
        bottomContext.fill(bottomRect)
    }
}

class VerticalView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let topRect = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height/2)
        UIColor(named: "AccentColor")!.set()
        guard let topContext = UIGraphicsGetCurrentContext() else { return }
        topContext.fill(topRect)

        let bottomRect = CGRect(x: 0 , y: rect.size.height/2, width: rect.size.width, height: rect.size.height/2)
        UIColor.white.set()
        guard let bottomContext = UIGraphicsGetCurrentContext() else { return }
        bottomContext.fill(bottomRect)
    }
}
extension UIView {
     func fadeIn() {
         // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
             self.alpha = 1.0 
             }, completion: nil)
    }

    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
}
extension UIView {
    func addShadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
    func addShadow2(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
            //layer.masksToBounds = false
            layer.shadowOffset = offset
            layer.shadowColor = color.cgColor
            layer.shadowRadius = radius
            layer.shadowOpacity = opacity

            let backgroundCGColor = backgroundColor?.cgColor
            backgroundColor = nil
            layer.backgroundColor =  backgroundCGColor
        }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

