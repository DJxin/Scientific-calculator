//
//  ViewController.swift
//  Scientific calculator
//
//  Created by 丁建新 on 16/7/20.
//  Copyright © 2016年 丁建新. All rights reserved.
//

import UIKit
class ViewController: UIViewController
{
     private var brain=CalculatorBrain()
    //与屏幕相关联
    @IBOutlet private weak var  display: UILabel!
    var userIsInTheMiddleOfTyping=false
    var displayValue:Double{
    get{
        return Double(display.text!)!
        }
    set{
        display.text=String(newValue)
        }
    }
    //按清除键的响应事件
    @IBAction func acBtn(sender: UIButton) {
        
    if userIsInTheMiddleOfTyping
    {
    brain.setOperand(displayValue)
    userIsInTheMiddleOfTyping=false
    }
    if let mathematicalSymbol=sender.currentTitle
    {
    brain.performOperation(mathematicalSymbol)
    }
    displayValue=brain.clean
    }
    //按运算符的响应事件
    @IBAction func performOperation(sender: UIButton)
    {
    if userIsInTheMiddleOfTyping
    {
    brain.setOperand(displayValue)
    userIsInTheMiddleOfTyping=false
    }
    if let mathematicalSymbol=sender.currentTitle
    {
    brain.performOperation(mathematicalSymbol)
    }
    displayValue=brain.result
    }
    //按小数点的响应事件
    var isDotTyped = false
    @IBAction func decBtnAction(sender:UIButton)
    {
    if !isDotTyped
    {
    if userIsInTheMiddleOfTyping
    {
    display.text = display.text! + "."
    }
    else {
            display.text = "0."
            userIsInTheMiddleOfTyping = true
         }
    isDotTyped=true
    }
    }
    //按数字键的响应事件
    @IBAction func numBtnAction(sender: UIButton)
    {
        let num=sender.currentTitle!
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay=display!.text
            display!.text=textCurrentlyInDisplay!+num
        }
        else
        {display!.text=num}
        userIsInTheMiddleOfTyping=true
    }
    //按左括号的响应事件
    var leftTyoed = false
    @IBAction func leftbracketBtnAction(sender:UIButton)
    {
        if !leftTyoed {
            if userIsInTheMiddleOfTyping {
                display.text =  "("+display.text!
            } else {
                display.text = "("
                userIsInTheMiddleOfTyping = true
            }
            leftTyoed=true
        }
    }
        //按右括号的响应事件
    var rightTyoed = false
    @IBAction func rightbracketBtnAction(sender:UIButton)
    {
        if !leftTyoed {
            if userIsInTheMiddleOfTyping {
                display.text =  display.text!+")"
            } else {
                display.text = "0.0"
                userIsInTheMiddleOfTyping = true
            }
            rightTyoed=true
        }
    }
       override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

