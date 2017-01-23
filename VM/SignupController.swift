//
//  SignupController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/21/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UITextFieldDelegate {
    
    // MARK: properties
    
    @IBOutlet weak var nameTxtFld: LinedTextField!
    @IBOutlet weak var passwordTxtFld: LinedTextField!
    @IBOutlet weak var mobileTxtFld: LinedTextField!
    @IBOutlet weak var emailTxtFld: LinedTextField!

    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        let back : UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClicked(sender:)))
        navigationItem.leftBarButtonItem = back
        
        nameTxtFld.text = ""
        passwordTxtFld.text = ""
        mobileTxtFld.text = ""
        emailTxtFld.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event Methods
    
    func backButtonClicked(sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        guard !nameTxtFld.text!.isEmpty else {
            showAlert(title: "Invalid username", message: "User name cannot be empty!")
            return
        }
        guard validatePWD(text: passwordTxtFld.text) else {
            showAlert(title: "Invalid Fields", message: "Password not valid")
            return
        }
        guard validatePhone(text: mobileTxtFld.text) else {
            showAlert(title: "Invalid Fields", message: "Phone number not valid")
            return
        }
        guard validateEmailText(text: emailTxtFld.text) else {
            showAlert(title: "Invalid Fields", message: "Not a valid Email format")
            return
        }
        let param : [String : String] = [Constants.UserParams.nameKey : nameTxtFld.text!,
                                         Constants.UserParams.passwordKey : passwordTxtFld.text!,
                                         Constants.UserParams.mobileKey : mobileTxtFld.text!,
                                         Constants.UserParams.emailKey : emailTxtFld.text!]
        //TODO: Some spin animation starts
        
        UserAuthentication.signupViaHttp(params: param) { (response) in
            if response.success {
                let dict : [String : String] = [Constants.UserParams.mobileKey : self.mobileTxtFld.text!,
                                                Constants.UserParams.passwordKey : self.passwordTxtFld.text!]
                UserAuthentication.loginViaHttp(params: dict, completion: { (re) in
                    if re.success {
                        self.performSegue(withIdentifier: "signupToHomeSegue", sender: nil)
                        //TODO: some spin stops
                        print(re.data ?? "success, but no data")
                    }else {
                        self.showAlert(title: "Error", message: re.errorMessage)
                        self.performSegue(withIdentifier: "signUpToLoginSegue", sender: nil)
                    }
                })
            }else {
                //TODO some spin stops
                self.showAlert(title: "Fail to register!", message: response.errorMessage)
            }
        }
    }
    @IBAction func toLoginButtonClicked() {
        performSegue(withIdentifier: "signUpToLoginSegue", sender: nil)
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
