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
    
    //MARK: Event methods
    func backButtonClicked() {
       _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func loginButtonClicked() {
        guard validatePhone(text: mobileTxtFld.text) else {
            showAlert(title: "Invalid Fields", message: "Phone number not valid")
            return
        }
        guard validatePWD(text: passwordTxtField.text) else {
            showAlert(title: "Invalid Fields", message: "Password not valid")
            return
        }
        let param :[String : String] = [Constants.UserParams.mobileKey : mobileTxtFld.text!,
                     Constants.UserParams.passwordKey : passwordTxtField.text!]
        
        UserAuthentication.loginViaHttp(params: param) { (response) in
            if response.success {
                UserAuthentication.currentUser = param
                //TODO: login success jump to home screen, store user mobile info
                self.performSegue(withIdentifier: "LoginToHomeSegue", sender: nil)
                print(response.data!)
            }else{
                self.showAlert(title:"Login Failed", message: response.errorMessage)
            }
        }
    }
    
    
    //MARK: Private methods
    
    
    
    private func setupViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let back : UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = back
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

