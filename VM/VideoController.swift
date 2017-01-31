//
//  VideoController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/30/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    private var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        
        fetchVideoFromServer()
    }
    
    //MARK: - Private Method
    private func fetchVideoFromServer() {
        guard let url = WebProvider.sharedInstance.constructParams(url: Constants.rjtMusicApi.BaseUrl + Constants.rjtMusicApi.VideoListService, params: [:]) else {
            showAlert(title: "Error", message: "Invalid Api Url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        WebProvider.sharedInstance.sendGet(request: request) { (res) in
            guard res.success else {
                self.showAlert(title: "Failed to Get Video list", message: res.errorMessage)
                return
            }
            guard let data = res.data as? [String : [Any]], let vs = data[Constants.VideoParams.videoListKey] else {
                self.showAlert(title: "Failed to Get Video list", message: "No found data on the server")
                return
            }
            self.videos = vs.map({ (dict) -> Video in
                return Video(dict as! [String : String])
            })
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.bounds.size.width * 9 / 16) + 16 + 60
        return CGSize(width: self.view.bounds.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
