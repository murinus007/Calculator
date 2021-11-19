//
//  CustomButton.swift
//  Calculator
//
//  Created by Alexey Sergeev on 22.10.2021.
//

import Foundation
import UIKit
import AVFoundation

final class CustomButton: UIButton {
    @IBInspectable var highlightedColor: UIColor = .gray
    @IBInspectable var customBackgroundColor: UIColor = .lightGray
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                if (self.isHighlighted) {
                    self.backgroundColor = self.highlightedColor
                }
                else {
                    self.backgroundColor = self.customBackgroundColor
                }
            }
        }
    }
    
     func playClick() {
           AudioServicesPlaySystemSound(1105)
       }
}
