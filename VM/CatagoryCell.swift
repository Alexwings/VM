//
//  CatagoryCell.swift
//  VM
//
//  Created by Xinyuan Wang on 1/24/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class CatagoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var albums : [AlbumDetail]?
    
    weak var controller : UIViewController?
    
    let musicCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let iv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.byRGB(red: 77, green: 104, blue: 140)
        label.numberOfLines = 1
        label.text = "RJT Top Played"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellId = "albumCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        setupViews()
    }
    
    private func setupViews(){
        backgroundColor = UIColor.clear
        addSubview(musicCollection)
        addSubview(nameLabel)
        
        //Horizontal constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: musicCollection)
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        
        //Virtical constraints
        addConstraintsWithFormat(format: "V:|[v0(25)]-10-[v1]|", views: nameLabel, musicCollection)
        
        musicCollection.register(AlbumCell.self, forCellWithReuseIdentifier: cellId)
        musicCollection.dataSource = self
        musicCollection.delegate = self
        
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumCell
        cell.album = albums?[indexPath.item]
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AlbumCell
        if let id = cell?.album?.id {
            if let contrl = self.controller as? MusicLibController {
                contrl.pendingView.isHidden = false
                contrl.pendingView.startSpin()
                AlbumDetail.getCurrentMusic(id: id) {
                    contrl.pendingView.stopSpin()
                    contrl.pendingView.isHidden = true
                    let alert = UIAlertController(title: "Choose your play style", message: "", preferredStyle: .actionSheet)
                    let action1 = UIAlertAction(title: "Mini Player", style: .default, handler: { (action) in
                        contrl.miniPlayer.album = AlbumDetail.currentMusic
                        contrl.miniPlayer.isHidden = false
                        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
                            contrl.miniPlayer.alpha = 1
                        }, completion: nil)
                    })
                    let action2 = UIAlertAction(title: "To Detail", style: .default, handler: { (action) in
                        contrl.performSegue(withIdentifier: "toAlbumDetailSegue", sender: nil)
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(action1)
                    alert.addAction(action2)
                    alert.addAction(cancel)
                    contrl.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: UICollectionViewDelegateFlowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.size.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}


