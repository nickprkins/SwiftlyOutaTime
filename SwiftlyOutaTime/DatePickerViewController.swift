//
//  DatePickerViewController.swift
//  SwiftlyOutaTime
//
//  Created by Nick Perkins on 5/13/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate {
    func acceptData(data: NSDate!)
}

class DatePickerViewController: UIViewController {
    
    var delegate : DatePickerViewControllerDelegate?
    var data : NSDate?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
            self.delegate?.acceptData(datePicker.date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
