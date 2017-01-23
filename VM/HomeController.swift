//
//  HomeController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func menuButtonClicked() {
        if let menuControl = slideMenuController() {
            menuControl.openLeft()
        }
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonClicked), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu : UIBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = menu
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
