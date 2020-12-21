//
//  StorageManager.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import Foundation

class StorageManager: NSObject
{
    static let sharedHelper = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    
    override init()
    {
       super.init()
    
    }
    func isUserLoggedIn() -> Bool
    {
        if userDefaults.hasValue(forKey: LoginKeys.LoginKeys_isUserLoggedState)
        {
            if let isUserLoggedState =  userDefaults.string(forKey: LoginKeys.LoginKeys_isUserLoggedState)
            {
                return isUserLoggedState == "_Yes____"
            }
        }
        return false
    }
    func saveCredentail(email:String,password:String,completion: @escaping (Bool)->(Void))
    {
        userDefaults.set(email, forKey: LoginKeys.LoginKeys_Email)
        userDefaults.set(password, forKey: LoginKeys.LoginKeys_pasword)
        userDefaults.set("_Yes____", forKey: LoginKeys.LoginKeys_isUserLoggedState)
        return completion(true)
    }
    
    struct LoginKeys
    {
         static let LoginKeys_Email = "LoginKeys_Email"
         static let LoginKeys_pasword = "LoginKeys_pasword"
         static let LoginKeys_isUserLoggedState = "LoginKeys_isUserLoggedState"
    }
}
extension UserDefaults {
    
    func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}
