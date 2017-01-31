//
//  MusicLibController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/24/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class MusicLibController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "CatagoryCell"
    
    private let urlStr : String = {
        let str = Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.MusicAlbumService
        return str
    }()
    
    let pendingView : PendingView = {
        let p = PendingView(frame: .zero)
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var miniPlayer: MusicPlayMiniView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pendingView.isHidden = true
        view.addSubview(pendingView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pending]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["pending" : pendingView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pending]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["pending" : pendingView]))
        
        miniPlayer.playButton.addTarget(self, action: #selector(self.playButtonClicked(_:)), for: .touchUpInside)
        miniPlayer.forwardButton.addTarget(self, action: #selector(self.forwardButtonClicked(_:)), for: .touchUpInside)
        miniPlayer.rewindButton.addTarget(self, action: #selector(self.rewindButtonClicked(_:)), for: .touchUpInside)
        miniPlayer.stopButton.addTarget(self, action: #selector(self.stopButtonClicked(_:)), for: .touchUpInside)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        miniPlayer.alpha = 0
        miniPlayer.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (miniPlayer.player?.currentItem != nil) {
            miniPlayer.player?.pause()
            removeAllPlayerObservers()
            miniPlayer.album = nil
        }
    }
    
    //MARK: - Helper
    func removeAllPlayerObservers() {
        miniPlayer.removeObserver(forKeyPath: "status")
    }
    private func fetchCatagory(param : [String : String], completion: @escaping ([AlbumDetail]) -> Void){
        if let url = WebProvider.sharedInstance.constructParams(url: urlStr, params: param) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            WebProvider.sharedInstance.sendGet(request: request, completion: { (res) in
                guard res.success else {
                    self.showAlert(title: "Web service fetch error", message: res.errorMessage)
                    return
                }
                if let responseData = res.data as? Dictionary<String, Array<Any>>{
                    var albums: [AlbumDetail] = []
                    for dict in responseData[Constants.MusicParams.musicListKey] as! [[String : Any]] {
                        let alb = AlbumDetail(params: dict)
                        albums.append(alb)
                    }
                    completion(albums)
                }
            })
        }
    }
    
    //MARK: - Event Methods
    
    
    func playButtonClicked(_ sender: UIButton){
        guard miniPlayer.player?.status == .readyToPlay else {
            showAlert(title: "Please Choose an music", message: "Please choose an music to play")
            return
        }
        if sender.isSelected {
            miniPlayer.player?.pause()
        }else{
            miniPlayer.player?.play()
        }
        sender.isSelected = !sender.isSelected
    }
    
    func forwardButtonClicked(_ sender: UIButton){
        guard miniPlayer.player?.timeControlStatus == .playing else {
            return
        }
        let time = CMTime(seconds: (miniPlayer.player?.currentTime().seconds)! + 5, preferredTimescale: (miniPlayer.player?.currentTime().timescale)!)
        miniPlayer.player?.currentItem?.seek(to: time)
    }
    
    func rewindButtonClicked(_ sender: UIButton){
        guard miniPlayer.player?.timeControlStatus == .playing else {
            return
        }
        let seconds = miniPlayer.player?.currentTime().seconds == 0 ? 0 : (miniPlayer.player?.currentTime().seconds)! - 5
        let time = CMTime(seconds: seconds, preferredTimescale: (miniPlayer.player?.currentTime().timescale)!)
        miniPlayer.player?.currentItem?.seek(to: time)
    }
    
    func stopButtonClicked(_ sender: UIButton){
        guard miniPlayer.player?.status == .readyToPlay else {
            return
        }
        if miniPlayer.playButton.isSelected {
            miniPlayer.playButton.isSelected = false
        }
        miniPlayer.player?.seek(to: CMTime(seconds: 0, preferredTimescale: (miniPlayer.player?.currentTime().timescale)!))
        miniPlayer.player?.pause()
        miniPlayer.player?.rate = 0.0
    }

    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.MusicParams.typeTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CatagoryCell
        cell.nameLabel.text = Constants.MusicParams.typeTitles[indexPath.item]
        cell.controller = self
        fetchCatagory(param: ["album_type" : Constants.MusicParams.typeValues[indexPath.item]]) { (albs) in
            cell.albums = albs
            cell.musicCollection.reloadData()
        }
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 210)
    }
}


