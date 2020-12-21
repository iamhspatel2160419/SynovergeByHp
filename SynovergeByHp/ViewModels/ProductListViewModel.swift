//
//  ProductListViewModel.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import Foundation
class ProductListViewModel {
    var productList: [Product]
    
    init() {
        self.productList = [Product]()
    }
    
    func fetchData(completion: @escaping (Bool)->(Void) )
    {
        self.productList = [Product]()
        DbManager.sharedDbManager.fetchData("Product")
        { (result) in
            if result.count > 0
            {
                for k in 0..<result.count
                {
                    let _Product = result[k] as! Product
                    self.productList.append(_Product)
                }
                self.productList = self.productList.reversed()
                return completion(true)
            }
            else
            {
                return completion(false)
            }
        }
    }
    func deleteProductAt(_ index: Int,product_id:String,completion: @escaping (Bool,[Product])->(Void))
    {
        DbManager.sharedDbManager.deleteSelectedId("Product",
                                                   strPredicate : "product_id = \(product_id)")
        {  (isDone) in
           if isDone
           {
             
             _ = self.productList.remove(at: index)
             return completion(true , self.productList)
           }
           else
           {
              return completion(false,self.productList)
           }
        }
    }
   
   
}


