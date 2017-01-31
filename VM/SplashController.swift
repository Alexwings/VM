//
//  ViewController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var logo: LogoView!
    
    private var timeRepeatsCounter = 0
    
    //Mark LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer: Timer = Timer(timeInterval: 2, repeats: true) { (time) in
            if self.timeRepeatsCounter < 2 {
                self.logoBump()
                self.timeRepeatsCounter += 1
            }else {
                time.invalidate()
                self.logoDisappear()
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
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserAuthenEntry")
        let jumpToSigin = {(this : SplashController) in
            UIView .animate(withDuration: 1, animations: {
                self.view.alpha = 0;
                self.present(vc, animated: false, completion: nil)
            })
        }
        //TODO add logoDisappear animation
        logo.addDisappearAnimation { (finish) in
            if finish {
                self.logo.isHidden = true
                self.logo.removeDisappearAnimation()
                jumpToSigin(self)
            }
        }
        
    }
    private func logoBump(){
        logo.addVBumpAnimation { (finish) in
            if finish {
                self.logo.addMBumpAnimation(completion: { (finish) in
                    if finish {
                        self.logo.removeAllAnimations()
                    }
                })
            }
        }
    }
    
    private func setupViews(){
        //TODO initial any views here
    
    }
    
    

}

