//
//  ViewController.swift
//  BullsEye
//
//  Created by Flatiron School on 5/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController
{
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var operation: UILabel!
    @IBOutlet weak var operationSlider: UISlider!
    @IBOutlet weak var minValueFirstSlider: UILabel!
    @IBOutlet weak var maxValueFirstSlider: UILabel!
    @IBOutlet weak var minValueSecondSlider: UILabel!
    @IBOutlet weak var maxValueSecondSlider: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    
    var currentValue = 0;
    var operationCurrentValue = 0;
    var targetValue = 0;
    var score = 0;
    var round = 0;
    var minValue = 0;
    var minValue2 = 0;
    var maxValue = 0;
    var maxValue2 = 0;
    var operationSymbol = ""
    var yourScore = 0;

    override func viewDidLoad()
    {
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        operationSlider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        operationSlider.setThumbImage(thumbImageHighlighted, forState: .Normal)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft")
        {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
            operationSlider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight")
        {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
            operationSlider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func operationGameCheck()
    {
       
        if operationSymbol == "+" && targetValue > maxValue + maxValue2
        {
            startNewRound()
        }
        else if operationSymbol == "+" && targetValue < minValue + minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "+" && targetValue < minValue + minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "-" && targetValue > minValue - minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "-" && targetValue < minValue - minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "-" && targetValue > maxValue - maxValue2
        {
            startNewRound()
        }
        else if operationSymbol == "*" && targetValue > maxValue * maxValue2
        {
            startNewRound()
        }
        else if operationSymbol == "*" && targetValue < minValue * minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "/" && targetValue < minValue2
        {
            startNewRound()
        }
        else if operationSymbol == "/" && targetValue < maxValue / maxValue2
        {
            startNewRound()
        }
        else if operationSymbol == "/" && targetValue > maxValue / maxValue2
        {
            startNewRound()
        }
        
    }

    @IBAction func showAlert()
    {
        
        if operationSymbol == "+"
        {
            yourScore = currentValue + operationCurrentValue
        }
        else if operationSymbol == "-"
        {
            yourScore = currentValue - operationCurrentValue
        }
        else if operationSymbol == "*"
        {
            yourScore = currentValue * operationCurrentValue
        }
        else if operationSymbol == "/"
        {
            yourScore = currentValue / operationCurrentValue
        }
        
        let difference = yourScore - targetValue
        var points = targetValue - difference
        score = score + points
        
        
        let title: String
        
        if difference == 0
        {
            title = "Perfect!"
            points += 100
        }
        else if difference < 5
        {
            title = "You almost had it!"
            points += 50
        }
        else if difference < 10
        {
            title = "Pretty good!"
        }
        else
        {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .Alert);
        
        let action = UIAlertAction(title: "OK", style: .Default,
                                    handler: {
                                                action in
                                                self.startNewRound()
                                                self.updateLabels()
                                             })
        
            alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBAction func sliderMoved(slider: UISlider)
    {
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        currentValue = lroundf(slider.value)
        //print ("the value: \(slider.value)")
    }
    
    @IBAction func sliderMoved2(operationSlider: UISlider)
    {
        operationSlider.minimumValue = Float(minValue2)
        operationSlider.maximumValue = Float(maxValue2)
        operationCurrentValue = lroundf(operationSlider.value)
        //print ("the value of second slider: \(operationSlider.value)")
    }
    
    func randomOperator()
    {
        let operatorArray = ["+", "-", "*", "/"]
        let i = Int(arc4random_uniform(UInt32(operatorArray.count)))
        operationSymbol = operatorArray[i]
        operationLabel.text = String(operationSymbol)
    }
    

    @IBAction func startOver()
    {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func values()
    {
        minValue = 1 + Int(arc4random_uniform(49))
        minValue2 = 1 + Int(arc4random_uniform(49))
        maxValue = 50 + Int(arc4random_uniform(50))
        maxValue2 = 50 + Int(arc4random_uniform(50))
        minValueFirstSlider.text = String(minValue)
        minValueSecondSlider.text = String(minValue2)
        maxValueFirstSlider.text = String(maxValue)
        maxValueSecondSlider.text = String(maxValue2)
    }
   
    func startNewRound()
    {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(199))
        currentValue = lroundf(slider.value)
        operationCurrentValue = lroundf(operationSlider.value)
        slider.value = Float(currentValue)
        operationSlider.value = Float(operationCurrentValue)
        values()
        randomOperator()
        operationGameCheck()
    }
    
    func updateLabels()
    {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        operationGameCheck()
    }
    
    func startNewGame()
    {
        score = 0
        round = 0
        startNewRound()
    }
    
}