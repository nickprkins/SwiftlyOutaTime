//
//  ViewController.swift
//  SwiftlyOutaTime
//
//  Created by Nick Perkins on 5/12/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DatePickerViewControllerDelegate {

    
    @IBOutlet weak var travelBackButton: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var presentLabel: UILabel!
    var originalBounds: CGRect!
    var originalCenter: CGPoint!
    
    var timer = NSTimer?()
    var currentSpeed: Double = 0
    let dateformatter = NSDateFormatter()
    let currentDate = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Time Circuits 2.0"
        self.destinationButton.setTitleColor(UIColor .darkGrayColor(), forState: UIControlState.Normal)
        
        dateformatter.dateFormat = "MMM dd YYYY"
        self.presentLabel.text = dateformatter.stringFromDate(currentDate)
        
        self.speedLabel.text = "\(Int(currentSpeed)) MPH"
        
        self.lastTimeLabel.text = "--- -- ----"
        
        travelBackButton.enabled = false
        originalBounds = self.travelBackButton.bounds;
        originalCenter = self.travelBackButton.center;
        
    }
    
    
    @IBAction func travelBackButton(sender: AnyObject) {
        
        //Travel Back in Time
        
        animateTravelBackButton()
        
        startTimer()
        
       self.view.userInteractionEnabled = false
        
        
    }
    
    func startTimer() {
        
        //Let the timer begin
        
        if ((timer == nil)) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateSpeed), userInfo: nil, repeats: true)
        }
    }
    
    
    func updateSpeed() {
        
        //Update Speed here.
        if currentSpeed != 88 {
            
            currentSpeed += 2
            
            self.speedLabel.text = "\(Int(currentSpeed)) MPH"
            
        }else{
            
            stopTimer()
            
            self.lastTimeLabel.text = self.presentLabel.text
            
            self.presentLabel.text = self.destinationButton.titleForState(UIControlState.Normal)
            
            self.destinationButton.setTitleColor(UIColor .darkGrayColor(), forState: UIControlState.Normal)
            
            let noneString = "--- -- ----"
            
            self.destinationButton.setTitle(noneString, forState: UIControlState.Normal)
            
            
            reduceSpeed()
        }
    }
    
    
    func reduceSpeed() {
        
        //reduce speed
        decreaseTimer()
        
        if currentSpeed != 0 {
            
            currentSpeed -= 1
            
            self.speedLabel.text = "\(Int(currentSpeed)) MPH"
            
        }else{
            
            stopTimer()
            
            self.view.userInteractionEnabled = true
            
            bringTravelBackButtonBack()
            
        }
    }
    
    
    func stopTimer() {
        
        //Stop The Timer
        timer!.invalidate()
        timer = nil
    }
    
    
    func decreaseTimer() {
        
        //lower timer
        if ((timer == nil)) {
        timer = NSTimer.scheduledTimerWithTimeInterval(-0.001, target: self, selector: #selector(ViewController.reduceSpeed), userInfo: nil, repeats: true)
        }
    }
    
    func acceptData(data: NSDate!) {
        let dateString = dateformatter.stringFromDate(data)
        self.destinationButton.setTitleColor(UIColor .redColor(), forState: UIControlState.Normal)
        self.destinationButton.setTitle(dateString, forState: UIControlState.Normal)
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Week 6 add UIDynamics to project
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    lazy var gravity:UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        return lazyGravity
    }()
    
    func animateTravelBackButton(){
        
        gravity.addItem(travelBackButton)
        gravity.gravityDirection = CGVectorMake(0, 0.8)
        animator.addBehavior(gravity)
        
    }
    
    func resetTravelBackButton() {
        self.animator.removeAllBehaviors()
        UIView.animateWithDuration(0.45, animations: {() -> Void in
            self.travelBackButton.bounds = self.originalBounds
            self.travelBackButton.center = self.originalCenter
            self.travelBackButton.transform = CGAffineTransformIdentity
        })
    }
    
    func bringTravelBackButtonBack(){
        
        resetTravelBackButton()
        
        NSLayoutConstraint(item: travelBackButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: travelBackButton, attribute: .Top, relatedBy: .Equal, toItem: speedLabel, attribute: .Bottom, multiplier: 1.0, constant: 75.0).active = true
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "datePickerSegue" {
            let destination = segue.destinationViewController as! DatePickerViewController
            destination.delegate = self
            travelBackButton.enabled = true
            
        }
        
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    

}