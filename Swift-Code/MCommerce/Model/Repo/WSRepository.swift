//
//  ProductRepository.swift
//  MCommerce
//
//  Created by Shubham bairagi on 20/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation
import CoreData

enum WSResponseData {
    case success(result: WSResponse)
    case failure
}

class WSRepository: BaseService {
    
    func getCategories(with completion: @escaping (WSResponseData) -> Void ) {
        
        let endPoint = EndPoints.getJson
        super.callEndPoint(endPoint: endPoint.rawValue) { (response: ServiceResponse<WSResponse>) in
            
            switch response {
            case .success(let result):
                completion(.success(result: result))
            default:
                completion(.failure)
            }
        }
    }
    
    // Storage Methods
    func fetchFromStorage() -> [CategoryModel]? {
        let managedObjectContext = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CategoryModel>(entityName: "Category")
//        let sortDescriptor1 = NSSortDescriptor(key: "role", ascending: true)
//        let sortDescriptor2 = NSSortDescriptor(key: "username", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        do {
            let categories = try managedObjectContext.fetch(fetchRequest)
            return categories
        } catch let error {
            print(error)
            return nil
        }
    }
    
    static func clearStorage() {
        let isInMemoryStore = AppDelegate.shared.persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }
        
        let managedObjectContext = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                for user in users {
                    managedObjectContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }

}
