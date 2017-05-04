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
  var player: AVPlayer? {
    get {
      return playerLayer.player
    }
    set {
      playerLayer.player = newValue
    }
  }
  
  var playerLayer: AVPlayerLayer {
    return layer as! AVPlayerLayer
  }
  
  // Override UIView property
  override static var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
}
