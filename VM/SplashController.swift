//
//  ViewController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var logoView: UIView!
    
    private var timeRepeatsCounter = 0
    
    //Mark LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer: Timer = Timer(timeInterval: 3, repeats: true) { (time) in
            if self.timeRepeatsCounter < 3 {
                self.logoBump()
                self.timeRepeatsCounter += 1
            }else {
                self.logoDisappear()
                time.invalidate()
            }
        }
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Event Methods
    
    
    
    //Mark Private Methods
    
    private func logoDisappear(){
        let jumpToSigin = {(this : SplashController) in
            
        }
        //TODO add logoDisappear animation
    }
    
    private func setupViews(){
        //TODO initial any views here
    
    }
    
    private func logoBump(){
        //TODO add logo bump animation chain
    }

}

