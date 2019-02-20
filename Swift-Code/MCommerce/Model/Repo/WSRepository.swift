//
//  ProductRepository.swift
//  MCommerce
//
//  Created by Shubham bairagi on 20/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

enum WSResponseData {
    case success(result: WSResponse)
    case failure
}

class WSRepository: BaseService {
    
    func getJsonData(with completion: @escaping (WSResponseData) -> Void ) {
        
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
}
