//
//  ViewController.swift
//  ColorTV Test App Swift
//
//  Created by Jordan Jasinski on 10/02/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

import UIKit

import RPLTAdFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {

        RPLTAdController.sharedAdController().currentPlacement = RPLTAdFrameworkPlacementMainMenu;
    }
    
    @IBAction func showRandomAd() {
        RPLTAdController.sharedAdController().adViewControllerWithCompletion({ (vc , error) in
            
            if((error) != nil) {
                NSLog("ERROR: %@", error!);
            }
            
            if((vc) != nil) {
                vc?.adCompleted = {
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                    });
                };
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.presentViewController(vc!, animated: true, completion: { () -> Void in
                        
                    });
                });
            }
        });
    }

}

