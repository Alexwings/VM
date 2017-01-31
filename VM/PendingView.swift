//
//  PendingView.swift
//  VM
//
//  Created by Xinyuan Wang on 1/26/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class PendingView: UIView {
    
    let spinView : UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        iv.color = UIColor.black
        iv.hidesWhenStopped = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpin(){
        spinView.startAnimating()
    }
    
    func stopSpin(){
        spinView.stopAnimating()
    }
    
    private func setupViews(){
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addSubview(spinView)
        
        //centerX, centerY, Height, width
        spinView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spinView.widthAnchor.constraint(equalTo: spinView.heightAnchor, multiplier: 1).isActive = true
        spinView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
