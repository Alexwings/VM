//
//  AlbumCell.swift
//  VM
//
//  Created by Xinyuan Wang on 1/28/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    // public accessible properties
    var album: AlbumDetail? {
        didSet {
            if let urlStr = album?.thumb{
                iconView.setImageUsingURLString(url: urlStr)
            }
            nameLabel.text = album?.name
            descLabel.text = album?.desc
        }
    }
    
    let iconView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.text = "24K Magic"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.text = "24K Magic is the third studio album by American singer Bruno Mars."
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //init functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        setupViews()
    }
    
    // set up subviews
    private func setupViews(){
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(descLabel)
        
        //set iconView's height
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: iconView, attribute: .width, multiplier: 1, constant: 0))
        
        // Horizontal constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : iconView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : descLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(30)][v2(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : iconView, "v1" : nameLabel, "v2" : descLabel]))
        
        
    }
}
