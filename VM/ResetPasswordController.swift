//
//  ResetPasswordController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class ResetPasswordController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mobileTxtFld: LinedTextField!
    @IBOutlet weak var oldPasswordTxtFld: LinedTextField!
    @IBOutlet weak var newPasswordTxtFld: LinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        let currMobile = UserAuthentication.currentUser?[Constants.UserParams.mobileKey] ?? " "
        mobileTxtFld.text = currMobile
        mobileTxtFld.isEnabled = false
        
    }
    
    //MARK: - Event Methods
    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetButtonClicked() {
        guard validatePhone(text: mobileTxtFld.text) else {
            showAlert(title: "Error!", message: "Phone number cannot be empty")
            mobileTxtFld.isEnabled = true
            return
        }
        guard validatePWD(text: oldPasswordTxtFld.text) else {
            showAlert(title: "Invalid Password Format", message: "Old Password format incorrect!")
            return
        }
        guard validatePWD(text: newPasswordTxtFld.text) else {
            showAlert(title: "Invalid Password Format", message: "New Password format incorrect!")
            return
        }
        let params : [String : String] = [Constants.UserParams.mobileKey : mobileTxtFld.text!,
                                          Constants.UserParams.passwordKey : oldPasswordTxtFld.text!,
                                          Constants.UserParams.newPasswordKey : newPasswordTxtFld.text!]
        UserAuthentication.resetPasswordViaHttp(params: params) { (response) in
            if response.success {
                var curUser = UserAuthentication.currentUser!
                curUser[Constants.UserParams.passwordKey] = self.newPasswordTxtFld.text!
                self.dismiss(animated: true, completion: nil)
            }else {
                self.showAlert(title: "Failed to update Password", message: "Old Password miss match, please try again")
                self.oldPasswordTxtFld.text = ""
                self.newPasswordTxtFld.text = ""
            }
        }
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
