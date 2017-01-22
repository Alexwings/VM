//
//  LoginController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class UserControlController: UIViewController {
    
    //Mark: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
    }
    @IBAction func sigUpButtonClicked(_ sender: UIButton) {
    }
    //Mark: Private Methods(Helper Methods)
    
}
