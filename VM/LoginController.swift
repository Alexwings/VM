//
//  LoginController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate{
    
    // MARK: properties
    @IBOutlet weak var mobileTxtFld: LinedTextField!
    @IBOutlet weak var passwordTxtField: LinedTextField!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Private methods
    
    private func setupViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let curTextField = textField as? LinedTextField {
            curTextField.lineColor = UIColor.white
            curTextField.updateUnderline(height: 2)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let curTextField = textField as? LinedTextField {
            curTextField.lineColor = UIColor.byRGB(red: 74, green: 109, blue: 148)
            curTextField.updateUnderline(height: 1)
        }

    }
}

