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

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in stackView.subviews where view is UIButton {
                view.layer.cornerRadius = 8.0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
    }
    
//MARK: exemplary implementation
    
    //Typical implementation within app. Please note that AdViewController should be initiated asynchronously in background and shown when required.
    @IBAction func showRandomAd() {
        showAdForPlacement(COLORAdFrameworkPlacementInAppPurchaseAbandoned)
    }
    
//MARK: presentation methods
    
    //The code placed below is written only for presentation purposes. Please note that developer should not choose type of ad shown based on particular placement mark. It is very unlikely such placement will be available for your application.
    
    @IBAction func showDiscoveryCenter() {
        showAdForPlacement(COLORAdFrameworkPlacementMainMenu)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
    }
    
    @IBAction func showInterstitial() {
        showAdForPlacement(COLORAdFrameworkPlacementStageFailed)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
    }
    
    @IBAction func showFullscreenAd() {
        showAdForPlacement(COLORAdFrameworkPlacementStageOpen)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
    }
    
    @IBAction func showVideoAd() {
        showAdForPlacement(COLORAdFrameworkPlacementLevelUp)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
    }
    
    
    func showAdForPlacement(placement: String) {
        COLORAdController.sharedAdController().adViewControllerForPlacement(placement, withCompletion:{ (vc , error) in
    
            guard let vc = vc else {
                print("Failed to initialize ad view controller, error: \(error?.description)")
                return
            }
    
            vc.adCompleted = {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
    
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(vc, animated: true, completion: nil)
            }
        })
    }

//MARK: UIFocusEnvironment
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if(context.nextFocusedView is UIButton) {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.2, 1.2)
                context.nextFocusedView?.layer.shadowColor = UIColor.blackColor().CGColor
                context.nextFocusedView?.layer.shadowOpacity = 0.3
                context.nextFocusedView?.layer.shadowRadius = 15
                context.nextFocusedView?.layer.shadowOffset = CGSize(width: 20, height: 20)
            }, completion: nil)
        }
        
        if(context.previouslyFocusedView is UIButton) {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.previouslyFocusedView?.transform = CGAffineTransformIdentity
                context.previouslyFocusedView?.layer.shadowColor = UIColor.clearColor().CGColor
                context.previouslyFocusedView?.layer.shadowOpacity = 0
            }, completion: nil)
        }
    }
}