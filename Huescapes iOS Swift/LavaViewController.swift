//
//  LavaViewController.swift
//  Huescapes iOS Swift
//
//  Created by John Wrobel on 10/17/15.
//

import UIKit



class LavaViewController: UIViewController {
    
    var redTimer = NSTimer()

    
    override func viewDidLoad() {
        makeRed()
        redTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("makeRed"), userInfo: nil, repeats: true)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
redTimer.invalidate()    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeRed() {
        let cache = PHBridgeResourcesReader.readBridgeResourcesCache()
        let bridgeSendAPI = PHBridgeSendAPI()
        
        for light in cache!.lights!.values {
            // don't update state of non-reachable lights
            if light.lightState!.reachable == 0 {
                continue
            }
            
            let lightState = PHLightState()
            
            
            lightState.hue = 0
            lightState.brightness = Int(arc4random()) % 254
            lightState.saturation = 254

            
            // Send lightstate to light
            bridgeSendAPI.updateLightStateForId(light.identifier, withLightState: lightState, completionHandler: { (errors: [AnyObject]!) -> () in
                
                if errors != nil {
                    let message = String(format: NSLocalizedString("Errors %@", comment: ""), errors)
                    NSLog("Response: \(message)")
                }
            })
            
        }
        
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
