//
//  WSResponse.swift
//  MCommerce
//
//  Created by Shubham bairagi on 20/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

class WSResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case categories
    }
    
    var categories: [CategoryModel]?
    
    // MARK: - Decodable
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decode([CategoryModel]?.self, forKey: .categories)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categories, forKey: .categories)
    }
}
