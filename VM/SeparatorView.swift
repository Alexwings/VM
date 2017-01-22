//
//  SeparatorView.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupviews()
    }
    
    private let sep_left: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.byRGB(red: 74, green: 109, blue: 148)
        return label
    }()
    
    private let sep_right: UILabel = {
     let label = UILabel()
        label.backgroundColor = UIColor.byRGB(red: 74, green: 109, blue: 148)
        return label
    }()
    
    private let sep_center: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textColor = UIColor.byRGB(red: 74, green: 109, blue: 148)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
        
    //Mark: Private
    private func setupviews(){
        backgroundColor = UIColor.clear
        addSubview(sep_left)
        addSubview(sep_right)
        addSubview(sep_center)
        
        
        addConstraintsWithFormat(format: "H:|[v0(150)]-(>=5)-[v1]-(>=5)-[v2(150)]|", views: sep_left, sep_center, sep_right)
        addConstraintsWithFormat(format: "V:|[v0]|", views: sep_center)
        
        addConstraint(NSLayoutConstraint(item: sep_center, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: sep_left, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
        addConstraint(NSLayoutConstraint(item: sep_left, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: sep_right, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
        addConstraint(NSLayoutConstraint(item: sep_right, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
