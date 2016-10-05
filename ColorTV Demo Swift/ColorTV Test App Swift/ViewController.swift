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
    var storedAd: COLORAdViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in stackView.subviews where view is UIButton {
                view.layer.cornerRadius = 8.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu as NSString
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
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu as NSString
    }
    
    @IBAction func showInterstitial() {
        showAdForPlacement(COLORAdFrameworkPlacementStageFailed)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu as NSString
    }
    
    @IBAction func showFullscreenAd() {
        showAdForPlacement(COLORAdFrameworkPlacementStageOpen)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu as NSString
    }
    
    @IBAction func showVideoAd() {
        showAdForPlacement(COLORAdFrameworkPlacementLevelUp)
        COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu as NSString
    }
    
    
    func showAdForPlacement(_ placement: String) {
        COLORAdController.sharedAdController().adViewController(forPlacement: placement, withCompletion:{ (vc , error) in
    
            guard let vc = vc else {
                print("Failed to initialize ad view controller, error: \((error as? NSError)?.description)")
                return
            }
            
            vc.addCompletionHandler({ (videoWatched) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })

            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }, expirationHandler: { (expiredVc) in
            print("Ad view controller \(expiredVc) has expired")
        })
    }

//MARK: UIFocusEnvironment
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(context.nextFocusedView is UIButton) {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                context.nextFocusedView?.layer.shadowColor = UIColor.black.cgColor
                context.nextFocusedView?.layer.shadowOpacity = 0.3
                context.nextFocusedView?.layer.shadowRadius = 15
                context.nextFocusedView?.layer.shadowOffset = CGSize(width: 20, height: 20)
            }, completion: nil)
        }
        
        if(context.previouslyFocusedView is UIButton) {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.previouslyFocusedView?.transform = CGAffineTransform.identity
                context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
                context.previouslyFocusedView?.layer.shadowOpacity = 0
            }, completion: nil)
        }
    }
}
