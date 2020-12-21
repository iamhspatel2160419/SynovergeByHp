//
//  Product+CoreDataProperties.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var qty: String?
    @NSManaged public var url: String?
    @NSManaged public var product_id: String?
    
}

extension Product : Identifiable {

}
