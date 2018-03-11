//
//  ViewController.swift
//  Saderli
//
//  Created by Siddhartha Maji on 16/02/18.
//  Copyright © 2018 Siddhartha Maji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    let delay = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // cancel the timer in case the button is tapped multiple times
        timer.invalidate()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
    }
    
    // function to be called after the delay
    @objc func delayedAction() {
        performSegue(withIdentifier: "segue_Page2", sender: nil)
    }

}

