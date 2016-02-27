//
//  ViewController.swift
//  ColorTV Test App Swift
//
//  Created by Jordan Jasinski on 10/02/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

import UIKit

import COLORAdFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in self.view.subviews {
            if(view .isKindOfClass(UIButton)) {
                view.layer.cornerRadius = 8.0;
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {

        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu;
    }
    
    @IBAction func showRandomAd() {
        COLORAdController.sharedAdController().adViewControllerForPlacement(COLORAdFrameworkPlacementInAppPurchaseAbandoned, withCompletion:{ (vc , error) in
            
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

