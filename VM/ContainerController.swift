//
//  ContainerController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerController: SlideMenuController{
    
    override func awakeFromNib() {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
        let mainController = storyB.instantiateViewController(withIdentifier: "Home")
        mainViewController = mainController
        let leftController = storyB.instantiateViewController(withIdentifier: "Left")
        leftViewController = leftController
        SlideMenuOptions.leftViewWidth = 200
        SlideMenuOptions.hideStatusBar = false
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.closeLeft()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
