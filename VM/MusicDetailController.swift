//
//  MusicDetailController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/28/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import AVFoundation

class MusicDetailController: UIViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var curTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pausePlayButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var timeObserver: Any?
    let player = AVPlayer()
    var curItem : AVPlayerItem? {
        didSet {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            player.replaceCurrentItem(with: curItem)
            player.addObserver(self, forKeyPath: #keyPath(player.currentItem.loadedTimeRanges), options: .new, context: nil)
            let value = CMTime(value: 1, timescale: 2)
            timeObserver = player.addPeriodicTimeObserver(forInterval: value, queue: DispatchQueue.main) { (currentTime) in
                if let duration = self.player.currentItem?.duration {
                    let seconds = Int(CMTimeGetSeconds(currentTime))
                    let value = Double(seconds) / CMTimeGetSeconds(duration)
                    let secText = String(format: "%02d", seconds % 60)
                    let minText = String(format: "%02d", seconds / 60)
                    self.curTimeLabel.text = "\(minText):\(secText)"
                    self.slider.value = Float(value)
                }
            }
            indicator.startAnimating()
        }
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cur = AlbumDetail.currentMusic {
            setupViews(album: cur)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if player.timeControlStatus == .playing {
            player.removeObserver(self, forKeyPath: #keyPath(player.currentItem.loadedTimeRanges))
            if let timeOB = timeObserver {
                player.removeTimeObserver(timeOB)
            }
        //remove curItem
            curItem = nil
            player.replaceCurrentItem(with: curItem)
        }
    }
    //MARK: - Event methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(player.currentItem.loadedTimeRanges), player.status == .readyToPlay{
                indicator.stopAnimating()
                player.play()
                if let duration = player.currentItem?.duration{
                    let totalSeconds = Int(CMTimeGetSeconds(duration))
                    let minText = String(format: "%02d", totalSeconds / 60)
                    let secondsText = String(format: "%02d", totalSeconds % 60)
                    totalTimeLabel.text = "\(minText):\(secondsText)"
                }
           
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        if let duration = player.currentItem?.duration {
            let seconds = Int(Float(CMTimeGetSeconds(duration)) * value)
            let seekTime = CMTime(seconds: Double(seconds), preferredTimescale: 1)
            player.seek(to: seekTime)
            let minText = String(format: "%02d", seconds / 60)
            let secondsText = String(format: "%02d", seconds % 60)
            curTimeLabel.text = "\(minText):\(secondsText)"
        }
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        if player.status == .readyToPlay {
            player.pause()
            player.rate = 0.0
            player.seek(to: CMTime(seconds: 0, preferredTimescale: 2))
            slider.value = 0
            pausePlayButton.isSelected = !pausePlayButton.isSelected
            curTimeLabel.text = "00:00"
        }
    }
    @IBAction func pausePlayerButtonClicked(_ sender: UIButton) {
        if sender.isSelected {
            player.play()
            player.rate = 1
        }else {
            player.pause()
        }
        sender.isSelected = !sender.isSelected
    }
    private func setupViews(album: AlbumDetail){
        if let imgUrl = album.thumb, let link = album.file?.link{
            
            thumbnail.setImageUsingURLString(url: imgUrl)
            thumbnail.contentMode = .scaleAspectFill
            thumbnail.clipsToBounds = true
            
            totalTimeLabel.text = "00:00"
            
            curTimeLabel.text = "00:00"
            
            let playerLayer = AVPlayerLayer(player: player)
            thumbnail.layer.addSublayer(playerLayer)
            
            indicator.hidesWhenStopped = true
            
            curItem = AVPlayerItem(url: URL(string: link)!)
            
            let img = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
            let pauseImg = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
            pausePlayButton.setImage(pauseImg, for: .normal)
            pausePlayButton.setImage(img, for: .selected)
            pausePlayButton.tintColor = pausePlayButton.isHighlighted ? UIColor.brown: UIColor.white
            
            let stopImg = UIImage(named: "stop")?.withRenderingMode(.alwaysTemplate)
            stopButton.setImage(stopImg, for: .normal)
            stopButton.tintColor = stopButton.isHighlighted ? UIColor.brown: UIColor.white
        }
    }

}
