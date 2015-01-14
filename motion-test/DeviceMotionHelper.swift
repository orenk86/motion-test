//
//  DeviceMotionHelper.swift
//  motion-test
//
//  Created by Oren Kosto on 1/13/15.
//  Copyright (c) 2015 Panda-OS. All rights reserved.
//

import UIKit
import CoreMotion

protocol DeviceMotionHelperDelegate {
    func deviceXYZDidChange(x:Double, y:Double, z:Double);
    func deviceRotationXYDidChange(rotation:Double);
    func deviceRotationXZDidChange(rotation:Double);
    func deviceRotationYZDidChange(rotation:Double);
}

let UPDATE_INTERVAL = 0.01;

private let sharedInstance = DeviceMotionHelper();
let manager = CMMotionManager();

class DeviceMotionHelper: NSObject {
    
    var delegate:DeviceMotionHelperDelegate?;
    
    class var sharedHelper : DeviceMotionHelper
    {
        return sharedInstance;
    }
    
    override init()
    {
        if manager.deviceMotionAvailable {
            manager.deviceMotionUpdateInterval = UPDATE_INTERVAL;
        }
        super.init();
    }
    
    func startUpdates()
    {
        if !manager.deviceMotionActive {
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data: CMDeviceMotion!, e: NSError!) -> Void in
                let rotationXY = M_PI - atan2(data.gravity.x, data.gravity.y);
                let rotationXZ = M_PI - atan2(data.gravity.x, data.gravity.z);
                let rotationYZ = M_PI - atan2(data.gravity.y, data.gravity.z);
                self.delegate?.deviceRotationXYDidChange(rotationXY);
                self.delegate?.deviceRotationXZDidChange(rotationXZ);
                self.delegate?.deviceRotationYZDidChange(rotationYZ);
                self.delegate?.deviceXYZDidChange(data.gravity.x, y: data.gravity.y, z: data.gravity.z);
            });
        }
    }
    
    func stopUpdates()
    {
        if manager.deviceMotionActive {
            manager.stopDeviceMotionUpdates();
        }
    }
}
