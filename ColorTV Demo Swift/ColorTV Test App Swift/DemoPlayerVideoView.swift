//
//  DemoPlayerVideoView.swift
//  ColorTV Demo Swift
//
//  Created by Szymon Litak on 04/05/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class DemoPlayerVideoView: UIView {
    
    let playerViewAccessQueue = DispatchQueue(label: "com.colortv.DemoApp.DemoVideoViewPlayerAccessQueue")
    
    var player: AVPlayer? {
        get {
            var result: AVPlayer?
            playerViewAccessQueue.sync {
                result = playerLayer.player
            }
            return result
        }
        set {
            playerViewAccessQueue.sync {
                playerLayer.player = newValue
            }
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
