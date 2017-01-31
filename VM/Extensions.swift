//
//  File.swift
//  YoutubeMimic
//
//  Created by Xinyuan Wang on 1/18/17.
//  Copyright © 2017 AlexW. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    static func byRGB(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format : String, views: UIView...) {
        var viewDict :[String:UIView] = [String : UIView]()
        for (index, view) in views.enumerated(){
            let key = "v" + String(index)
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views:viewDict))
    }
}

extension UIViewController {
    func showAlert(title:String, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func validateEmailText(text: String?) -> Bool{
        guard let str = text else {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[\\w\\d]+@[\\w\\d]+\\.[\\w\\d]+$")
        return predicate.evaluate(with: str)
    }
    
    func validatePWD(text : String?) -> Bool{
        guard let str = text else {
            return false
        }
        guard (str.characters.count >= 4 && str.characters.count <= 12) else {
            return false
        }
        let UpPredicate = NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*")
        let lowPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let numPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        return UpPredicate.evaluate(with: str) && lowPredicate.evaluate(with: str) && numPredicate.evaluate(with: str)
    }
    
    func validatePhone(text : String?) -> Bool {
        guard let str = text else {
            return false
        }
        guard str.characters.count >= 8 else {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[0-9]+")
        return predicate.evaluate(with: str)
    }
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func setImageUsingURLString(url: String){
        guard let urlStr = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) else {
            return
        }
        if let image = imageCache.object(forKey:urlStr as NSString){
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: urlStr)!) { (data, res, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "bruno_mars_icon")
                    print(error!.localizedDescription)
                }
                return
            }
            guard let r = res as? HTTPURLResponse, r.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "bruno_mars_icon")
                }
                return
            }
 
            let img = UIImage(data: data!)!
            imageCache.setObject(img, forKey: url as NSString)
            DispatchQueue.main.async {
                self.image = img
            }
        }.resume()
    }
}
