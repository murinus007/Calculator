//
//  ViewController.swift
//  Calculator
//
//  Created by Alexey Sergeev on 12.10.2021.
//

import UIKit

enum Operations: Int {
    case plus = 11
    case minus = 12
    case multiply = 13
    case division = 14
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    var operation: Operations?
    var currentValue: Double = 0
    var isOperationClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        buttons.forEach { button in
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    func setButtonClick(by tag: Int) {
        isOperationClicked = true
        
        let button = buttons.first { button in
            button.tag == tag }
        
        button?.backgroundColor = .white
        button?.setTitleColor(.systemOrange, for: .normal)
    }
    
    func resetButtons() {
        isOperationClicked = false
        buttons.filter { $0.tag == 11 || $0.tag == 12 || $0.tag == 13 || $0.tag == 14 }.forEach { button in
            button.backgroundColor = .systemOrange
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func operations(_ sender: CustomButton) {
        resetButtons()
        currentValue = Double(digitLabel.text ?? "0") ?? 0
        operation = .init(rawValue: sender.tag)
        setButtonClick(by: sender.tag)
        sender.playClick()
    }
    
    @IBAction func addSymbols(_ sender: CustomButton) {
        let oldValue = digitLabel.text ?? ""
        if digitLabel.text == "-0", sender.tag != 10 {
            digitLabel.text = "-" + String(sender.tag)
    } else if oldValue != "0" && sender.tag != 10 && !isOperationClicked{
            digitLabel.text =  oldValue + String(sender.tag)
        } else if sender.tag == 10 {
            if !oldValue.contains(".") {
            digitLabel.text = oldValue + "."
            }
        } else {
            digitLabel.text = String(sender.tag)
        }
        sender.playClick()
        resetButtons()
        }
    
    
    @IBAction func deleteAllSymbols(_ sender: CustomButton) {
        digitLabel.text = "0"
        sender.playClick()
    }
    
    @IBAction func deleteLastSymbol(_ sender: CustomButton) {
        var deletedValue = digitLabel.text ?? ""
        deletedValue.removeLast()
        digitLabel.text = deletedValue
        if deletedValue == "" {
            digitLabel.text = "0"
        }
        sender.playClick()
    }
    
    
    @IBAction func reverseNumber(_ sender: CustomButton) {
        if var text = digitLabel.text, text.hasPrefix("-") {
            text.removeFirst()
            digitLabel.text = text
        } else {
            digitLabel.text = "-" + (digitLabel.text ?? "")
        }
        sender.playClick()
    }
    
    @IBAction func result(_ sender: CustomButton) {
        var result = 0.0
        sender.playClick()

        switch operation {
        case .plus:
            result = currentValue + (Double(digitLabel.text ?? "0") ?? 0)
        case .minus:
            result = currentValue - (Double(digitLabel.text ?? "0") ?? 0)
        case .division:
            result = currentValue / (Double(digitLabel.text ?? "0") ?? 0)
        case .multiply:
            result = currentValue * (Double(digitLabel.text ?? "0") ?? 0)

        default:
            break
        }
        
        let isInteger = floor(result) == result
        digitLabel.text = isInteger ? String(Int(result)) : String(result)
    }
}
