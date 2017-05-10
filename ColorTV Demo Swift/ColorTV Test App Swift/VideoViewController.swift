//
//  VideoViewController.swift
//  ColorTV Demo Swift
//
//  Created by Szymon Litak on 04/05/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

import COLORAdFramework

class VideoViewController: UIViewController {
    
    let kPlaybackLikelyToKeepUpKeyPath = "currentItem.playbackLikelyToKeepUp"
    var isVideoPlaying: Bool = false
    
    var videoView: DemoPlayerVideoView {
        return view as! DemoPlayerVideoView
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private var recommendationVC: COLORRecommendationViewController!
    private var nextItemVC: COLORNextItemRecommendationViewController!
    
    var videoPlayer: AVPlayer? {
        return videoView.playerLayer.player;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playPauseBtnRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPauseButtonClicked))
        playPauseBtnRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.playPause.rawValue)]
        view.addGestureRecognizer(playPauseBtnRecognizer)
        view.backgroundColor = UIColor.black
        loadingIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer?.addObserver(self, forKeyPath: "rate", options: [.new, .old], context: nil)
        videoPlayer?.addObserver(self, forKeyPath: kPlaybackLikelyToKeepUpKeyPath, options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "rate") {
            if let rate = change?[.newKey] as? Float, rate == 0 {
                if recommendationVC != nil, presentedViewController != recommendationVC {
                    present(recommendationVC, animated: true, completion: nil)
                }
                
                if let isLikely = videoPlayer?.currentItem?.isPlaybackLikelyToKeepUp, isLikely {
                    loadingIndicator.stopAnimating()
                } else {
                    loadingIndicator.startAnimating()
                }
            }
        } else if keyPath == kPlaybackLikelyToKeepUpKeyPath {
            if let likelyToKeepUp = change?[.newKey] as? Bool {
                likelyToKeepUp ? loadingIndicator.stopAnimating() : loadingIndicator.startAnimating()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoPlayer?.removeObserver(self, forKeyPath: "rate")
        self.videoPlayer?.removeObserver(self, forKeyPath: kPlaybackLikelyToKeepUpKeyPath)
    }
    
    func loadVideo(with url: URL, identifier: String) {
        var videoItem = AVPlayerItem(url: url)
        
        if let videoPlayer = videoPlayer {
            videoPlayer.replaceCurrentItem(with: videoItem)
        } else {
            videoView.player = AVPlayer(playerItem: videoItem)
        }
        
        COLORAdController.sharedAdController().contentRecommendationController(forPlacement: COLORAdFrameworkPlacementVideoStart, andVideoId: identifier) {
            (vc: COLORRecommendationViewController?, error: Error?) in
            guard let vc = vc, error == nil else {
                NSLog("::>> ConRec ERROR: \(error?.localizedDescription ?? "Unrecognized error")")
                return
            }
            vc.itemSelected = {(videoId: String, videoURL: URL, clickParams: [AnyHashable : Any]?) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.loadVideo(with: videoURL, identifier: videoId)
                        self.play()
                    }
                }
            }
            vc.contentRecommendationClosed = {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.play()
                    }
                }
            }
            self.recommendationVC = vc
        }
        play()
    }
    
    func play() {
        videoPlayer?.play()
        isVideoPlaying = true
    }
    
    func pause() {
        videoPlayer?.pause()
        isVideoPlaying = false
    }
    
    func playPauseButtonClicked(sender: Any) {
        isVideoPlaying ? pause() : play()
    }
}
