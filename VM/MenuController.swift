//
//  MenuController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    @IBOutlet weak var logoHeaderView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func setupViews(){
        let sep : UILabel = UILabel()
        sep.backgroundColor = UIColor.lightGray
        logoHeaderView.addSubview(sep)
        tableView.tableHeaderView = logoHeaderView
        tableView.alwaysBounceVertical = false
        logoHeaderView.addConstraintsWithFormat(format: "H:|[v0]|", views: sep)
        logoHeaderView.addConstraintsWithFormat(format: "V:[v0(1)]|", views: sep)
    }
    

    //MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath)
        var title = "title"
        switch indexPath.row {
        case 0:
            title = "Reset Password"
            break
        case 1:
            title = "Log Out"
            break
        default:
            break
        }
        cell.textLabel?.text = title
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "resetPasswordSegue", sender: nil)
            break
        case 1:
            UserAuthentication.currentUser = nil
            performSegue(withIdentifier: "logoutSegue", sender: nil)
            break
        default:
            break
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
