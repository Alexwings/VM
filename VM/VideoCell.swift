//
//  VideoCell.swift
//  VM
//
//  Created by Xinyuan Wang on 1/30/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var video: Video? {
        didSet {
            if let v = video {
                displayView.setImageUsingURLString(url: v.thumb)
                nameLabel.text = v.name
                textLabel.text = v.desc
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    let displayView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "brunoMars")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "this is a placeholder text"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Baskerville-SemiBoldItalic", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "this is a placeholder text"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Baskerville-Italic", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Private Methods
    private func setupViews(){
        addSubview(displayView)
        
        let imgHeight = frame.size.width * 9 / 16

        displayView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        displayView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        displayView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        displayView.heightAnchor.constraint(equalToConstant: imgHeight).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: displayView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30)
        
        addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        textLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 30)
        
    }
}
