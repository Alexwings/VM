//
//  MusicPicView.swift
//  VM
//
//  Created by Xinyuan Wang on 1/23/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class MusicPicView: UIView{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        imageCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    let cellId = "imageCell"
    
    lazy var pageIndicator : UIPageControl = {
        let pgc = UIPageControl(frame: .zero)
        pgc.size(forNumberOfPages: 4)
        pgc.currentPageIndicatorTintColor = UIColor.lightGray
        pgc.pageIndicatorTintColor = UIColor.byRGB(red: 45, green: 62, blue: 82)
        pgc.hidesForSinglePage = true
        return pgc
    }()
    
    let imageCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vi = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vi.isPagingEnabled = true
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.backgroundColor = UIColor.byRGB(red: 45, green: 62, blue: 82)
        vi.showsHorizontalScrollIndicator = false
        return vi
    }()

    private func setupViews() {
        addSubview(imageCollection)
        insertSubview(pageIndicator, aboveSubview: imageCollection)
       
        pageIndicator.addTarget(self, action: #selector(self.pageChanged(_:)), for:.valueChanged)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageCollection)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageCollection)
        addConstraintsWithFormat(format: "H:|[v0]|", views: pageIndicator)
        addConstraintsWithFormat(format: "V:[v0(40)]-10-|", views: pageIndicator)
    }
    func pageChanged(_ page: UIPageControl) {
        let index = IndexPath(item: page.currentPage, section: 0)
        imageCollection.scrollToItem(at: index, at:.centeredHorizontally, animated: true)
    }
}
