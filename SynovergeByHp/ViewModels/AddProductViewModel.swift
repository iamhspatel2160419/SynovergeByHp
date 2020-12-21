//
//  AddProductViewModel.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import Foundation
import UIKit

struct AddProductViewModel: Validatable {
    
    var productName: String?
    var productQty: String?
    var productImageUrl:String?
    
    func validate() -> (Bool,String)
    {
        if self.productImageUrl == nil || self.productImageUrl!.isEmpty
        {
            return (false,"Choose product Image from photo album.!")
        }
        else if self.productName == nil || self.productName!.isEmpty
        {
            return (false,"Enter product name !")
        }
        else if self.productQty == nil || self.productQty!.isEmpty
        {
            return (false,"Enter product Quantity !")
        }
        else
        {
            return (true,"")
        }
    }
    
    func saveProduct(completion: @escaping (Bool)->(Void))
    {
        guard let _productName = self.productName,
              let _productQty = self.productQty,
              let _imageUrl = self.productImageUrl else {
            return completion(false)
        }
        
        let _productData = NSMutableDictionary()
        _ = Date()
        _productData.setValue(_productName, forKey: "name")
        _productData.setValue(_productQty, forKey: "qty")
        _productData.setValue(_imageUrl, forKey: "url")
        _productData.setValue(getCount(), forKey: "product_id")
        
        
        DbManager.sharedDbManager.insertIntoTable("Product",
                                                  dictInsertData:
                                                    _productData)
        {
            isDone in
            if isDone == true
            {
                return completion(isDone)
            }
            return completion(false)
        }
    }
    func getCount() -> String
    {
        var count = ""
        DbManager.sharedDbManager.fetchData("Product")
        { (result) in
            if result.count > 0
            {
               count = "\(result.count+1)"
            }
            else
            {
               count = "1"
            }
        }
        return count
    }
    
    func openSettingDirectory()
    {
        let alertController = UIAlertController (title: "Warning !", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        let appObject = Helper.sharedHelper.getRootViewController()
        appObject?.present(alertController, animated: true, completion: nil)
    }
    
}
extension Date {
    func format(format:String = "dd-MM-yyyy hh-mm-ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = (NSLocale(localeIdentifier: "en_US_POSIX") as Locale)
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
