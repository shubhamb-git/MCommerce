//
//  CategoryModel.swift
//  MCommerce
//
//  Created by Shubham bairagi on 20/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit
import CoreData

class CategoryModel: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id, name
        case products
        case child_categories
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var identifier: NSNumber?
    @NSManaged var name: String?

    @NSManaged var childCategoriesId: [NSNumber]?
    
    var childCategories: [CategoryModel]?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext) else {
                fatalError("Failed to decode Category")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
      
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        if let identifier = try values.decode(Int?.self, forKey: .id) {
            self.identifier = identifier as NSNumber
        } else {
            fatalError("Failed to decode Category's id")
        }
        
        if let childIds = try values.decode([Int]?.self, forKey: .child_categories) {
            self.childCategoriesId = childIds as [NSNumber]
        } else {
            fatalError("Failed to decode Sub Category's id")
        }
        
        name = try values.decode(String?.self, forKey: .name)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let identifier = identifier {
            try container.encode(Int(truncating: identifier), forKey: .id)
        } else {
            fatalError("Failed to encoder Category's id")
        }
        if let childIds = childCategoriesId {
            let mappedArr = childIds.map({Int(truncating: $0)})
            try container.encode(mappedArr, forKey: .child_categories)
        } else {
            fatalError("Failed to encoder Category's id")
        }
        
        try container.encode(name, forKey: .name)
    }
}
