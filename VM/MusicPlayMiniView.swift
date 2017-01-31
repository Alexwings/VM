//
//  MusicPlayMiniView.swift
//  VM
//
//  Created by Xinyuan Wang on 1/24/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import AVFoundation


class MusicPlayMiniView: UIView {
    
    var album : AlbumDetail? {
        didSet {
            if let cur = album, (cur.file != nil) {
                if player?.timeControlStatus == .playing {
                    player?.pause()
                    removeObserver(forKeyPath: "somthing")
                }
                thumnail.setImageUsingURLString(url: (cur.thumb)!)
                nameLabel.text = cur.name
                if let url = URL(string: cur.file!.link) {
                    let playerItem = AVPlayerItem(url: url)
                    player = AVPlayer(playerItem: playerItem)
                    player?.addObserver(self, forKeyPath: #keyPath(player.currentItem.loadedTimeRanges), options: .new, context: nil)
                }
            }
        }
    }
    let playerLayer: AVPlayerLayer = {
        let p = AVPlayerLayer()
        return p
    }()
    //public properties
    var player: AVPlayer? {
        didSet {
            playerLayer.player = player
        }
    }
    
    let thumnail : UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(named: "bruno_mars_icon")
        imgv.contentMode = .scaleAspectFit
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "24K Magic"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stopButton : UIButton = {
        let b = UIButton(type: .custom)
        let img = UIImage(named: "stop")?.withRenderingMode(.alwaysTemplate)
        b.setImage(img, for: .normal)
        b.tintColor = b.isHighlighted ? UIColor.brown : UIColor.white
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
 
    
    let rewindButton : UIButton = {
        let b = UIButton(type: .custom)
        let img = UIImage(named: "rewind")?.withRenderingMode(.alwaysTemplate)
        b.setImage(img, for: .normal)
        b.tintColor = b.isHighlighted ? UIColor.brown : UIColor.white
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let forwardButton : UIButton = {
        let b = UIButton(type: .custom)
        let img = UIImage(named: "fast_forward")?.withRenderingMode(.alwaysTemplate)
        b.setImage(img, for: .normal)
        b.tintColor = b.isHighlighted ? UIColor.brown : UIColor.white
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let playButton : UIButton = {
        let b = UIButton(type: .custom)
        let imgPlay = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
        let imgPause = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        b.setImage(imgPlay, for: .normal)
        b.setImage(imgPause, for: .selected)
        b.tintColor = b.isHighlighted ? UIColor.brown : UIColor.white
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // private properties
    private let stack : UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .equalCentering
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
   // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else {
            return
        }
        if key == #keyPath(player.currentItem.loadedTimeRanges) {
            player?.play()
            playButton.isSelected = true
        }
    }
    
    func removeObserver(forKeyPath: String){
        player?.removeObserver(self, forKeyPath: #keyPath(player.currentItem.loadedTimeRanges))
    }
    
    // private methods
    
    
    private func setupViews(){
        
        backgroundColor = UIColor.byRGB(red: 45, green: 62, blue: 82)
        
        layer.addSublayer(playerLayer)
        
        addSubview(thumnail)
        addSubview(nameLabel)
        addSubview(stack)
        
        stack.addArrangedSubview(rewindButton)
        stack.addArrangedSubview(playButton)
        stack.addArrangedSubview(stopButton)
        stack.addArrangedSubview(forwardButton)
        
        //thumnail constraint, top, bottom left, width == height
        addConstraint(NSLayoutConstraint(item: thumnail, attribute: .top, relatedBy: .equal, toItem: self, attribute:.top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumnail, attribute: .bottom, relatedBy: .equal, toItem: self, attribute:.bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumnail, attribute: .left, relatedBy: .equal, toItem: self, attribute:.left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumnail, attribute: .width, relatedBy: .equal, toItem: thumnail, attribute: .height, multiplier: 1, constant: 0))
        
        //stack left, bottom. height, right
        addConstraint(NSLayoutConstraint(item: stack, attribute: .left, relatedBy: .equal, toItem: thumnail, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: stack, attribute: .bottom, relatedBy: .equal, toItem: thumnail, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: stack, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16))
        
        // title top, left right, bottom
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: thumnail, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: stack, attribute: .top, multiplier: 1, constant: -16))
        //buttons width = height
        addConstraint(NSLayoutConstraint(item: forwardButton, attribute: .width, relatedBy: .equal, toItem: forwardButton, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: playButton, attribute: .width, relatedBy: .equal, toItem: playButton, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: rewindButton, attribute: .width, relatedBy: .equal, toItem: rewindButton, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stopButton, attribute: .width, relatedBy: .equal, toItem: stopButton, attribute: .height, multiplier: 1, constant: 0))
    }
}
