//
//  NSObjectExtension.swift
//  MCommerce
//
//  Created by Shubham bairagi on 20/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    // Name Of class
    class var stringRepresentation: String {
        let name = String(describing: self)
        return name
    }
}
