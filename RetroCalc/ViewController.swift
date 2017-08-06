//
//  ViewController.swift
//  RetroCalc
//
//  Created by David Sternheim on 8/1/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorVC: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    var runningNum = ""
    var btnSound: AVAudioPlayer!
    var leftNum = ""
    var rightNum = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") //Bundle is the bundle for the app that stores all the files and "things" for the application and the path for resource is simply going to the specified file in the format forResource: "fileName", ofType: "fileType"
        //Note: IOS uses URLs
        let soundURL = URL(fileURLWithPath: path!) // creating URL by "unwrapping(!)" the path constant essentially promising that the file path will be there
        
        //Exception handling for if the sound cannot be played. If it passes the expception then the sound will .prepareToPlay()
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLabel.text="0"
    
    }

    @IBAction func numberPressed(sender: UIButton){
       // playSound() //uncomment to enable sounds
        
        runningNum+="\(sender.tag)" //user initializing running number with button press
        outputLabel.text=runningNum
    }
    
    @IBAction func dividePressed(sender: AnyObject){
        operationPressed(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject){
        operationPressed(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(sender: AnyObject){
        operationPressed(operation: .Subtract)
    }
    
    @IBAction func additionPressed(sender: AnyObject){
        operationPressed(operation: .Add)
    }
    
    @IBAction func equalPressed(sender: AnyObject){
        operationPressed(operation: currentOperation)
    }
    
    @IBAction func clearPressed(sender: AnyObject){
        operationPressed(operation: .Clear)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }//function to simply play the sound when invoked
    
    func operationPressed(operation: Operation){
        //playSound() //uncomment to play sound on operation button presses
        
        if currentOperation != Operation.Empty{
            
            if operation == Operation.Clear {
                leftNum = ""
                rightNum = ""
                runningNum = ""
                outputLabel.text="0"
                currentOperation = Operation.Empty
            } else if runningNum != "" {
                rightNum = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Add{
                    result = "\(Double(leftNum)! + Double(rightNum)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftNum)! - Double(rightNum)!)"
                }else if currentOperation == Operation.Multiply{
                    result="\(Double(leftNum)! * Double(rightNum)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftNum)! / Double(rightNum)!)"
                }
                
                leftNum=result
                outputLabel.text=result
                currentOperation = operation
            }
            
        }else{
            leftNum=runningNum
            runningNum=""
            currentOperation = operation
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

