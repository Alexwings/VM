//
//  LabeledTextField.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

@IBDesignable class LinedTextField: UITextField {
    
    @IBInspectable
    var lineColor: UIColor? {
        didSet {
            if let color = lineColor {
                self.underline.backgroundColor = color
                setNeedsDisplay()
            }
        }
    }
    
    let underline: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false;
        let heightConstriant = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        heightConstriant.identifier = "underlineHeight"
        label.addConstraint(heightConstriant)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    override func layoutSubviews() {
        if let color = lineColor {
            underline.backgroundColor = color
        }
    }
    
    func updateUnderline(height:Int) {
        for cons in underline.constraints {
            if cons.identifier == "underlineHeight" {
                cons.constant = CGFloat(height)
                break
            }
        }
        setNeedsLayout()
    }
    
    //Mark: Private Methods
    
    private func setupViews() {
        borderStyle = .none
        addSubview(underline)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: underline)
        addConstraintsWithFormat(format: "V:[v0]|", views: underline)
    }
}
