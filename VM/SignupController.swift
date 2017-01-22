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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event Methods
    @IBAction func signupButtonClicked(_ sender: UIButton) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
