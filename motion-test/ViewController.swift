//
//  ViewController.swift
//  motion-test
//
//  Created by Oren Kosto on 1/13/15.
//  Copyright (c) 2015 Panda-OS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DeviceMotionHelperDelegate {

    @IBOutlet weak var rotationXYLabel: UILabel!
    @IBOutlet weak var rotationXZLabel: UILabel!
    @IBOutlet weak var rotationYZLabel: UILabel!
    @IBOutlet weak var deviceX: UILabel!
    @IBOutlet weak var deviceY: UILabel!
    @IBOutlet weak var deviceZ: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DeviceMotionHelper.sharedHelper.delegate = self;
        DeviceMotionHelper.sharedHelper.startUpdates();
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        DeviceMotionHelper.sharedHelper.stopUpdates();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    func deviceXYZDidChange(x: Double, y: Double, z: Double) {
        deviceX.text = NSString(format: "%.2f", x);
        deviceY.text = NSString(format: "%.2f", y);
        deviceZ.text = NSString(format: "%.2f", z);
    }
    
    func deviceRotationXYDidChange(rotation: Double) {
        rotationXYLabel.text = NSString(format: "%.2f", rotation);
    }
    
    func deviceRotationXZDidChange(rotation: Double) {
        rotationXZLabel.text = NSString(format: "%.2f", rotation);
    }
    
    func deviceRotationYZDidChange(rotation: Double) {
        rotationYZLabel.text = NSString(format: "%.2f", rotation);
    }
}

