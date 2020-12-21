//
//  LoginViewModel.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import Foundation


struct LoginViewModel: Validatable {
    
    var password: String?
    var email: String?
    
    func validate() -> (Bool,String)
    {
        if let email = self.email
        {
            if email.isEmpty
            {
                return (false,"Enter email")
            }
            else if let password = self.password
            {
                if password.isEmpty
                {
                    return (false,"Enter password")
                }
                else
                {
                    return (true,"")
                }
            }
        }
        return (false,"Enter email")
    }
    
    func saveCredential(completion: @escaping (Bool)->(Void))
    {
        if let email = self.email,let password = self.password
        {
            if email == "test@gmail.com" && password == "Admin@123"
            {
                StorageManager.sharedHelper.saveCredentail(email: self.email!,
                                                           password: self.password!)
                {
                    isSuccess in
                    if isSuccess
                    {
                        return completion(true)
                    }
                    else
                    {
                        return completion(false)
                    }
                }
            }
            else
            {
                Helper.sharedHelper.showAlert("Invalid Credential",
                                              alertMessage: "Enter \n Email : test@gmail.com \n password : Admin@123 ")
            }
        }
    }
}
