//
//  LoginViewController.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    private var vm = LoginViewModel()
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
  
    override func viewDidLoad()
    {
        
    }
    
    @IBAction func btnSaveLoginInfo(_ sender: UIButton) {
    
        let email = self.txtFieldEmail.text
        let password = self.txtFieldPassword.text
        self.vm.email = email
        self.vm.password = password
        if(self.vm.validate().0 == true)
        {
            // verify user locally 
            vm.saveCredential { isSuccess in
                if isSuccess == true
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigationHomeController = storyboard.instantiateViewController(withIdentifier: "navigationHomeController")
                    UIApplication.shared.windows.first?.rootViewController = navigationHomeController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
        else
        {
            Helper.sharedHelper.showAlert("Error !",
                                          alertMessage: self.vm.validate().1)
        }
    }
}
