//
//  CategoryViewModel.swift
//  MCommerce
//
//  Created by Shubham bairagi on 06/03/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

protocol CategoryModelDelegate: class {
    func didReceiveResponse()
    func didFailed()
}

class CategoryViewModel {
    
    lazy var categories = [CategoryModel]()
    var repository: WSRepository?
    weak var delegate: CategoryModelDelegate?
    
    init(with delegate: CategoryModelDelegate) {
        self.delegate = delegate
        repository = WSRepository()
    }
    
    func getCategories(with parentCategoryId: String? = nil) {
        
        guard let repo = repository else { return }
        
        if let parentCategoryId = parentCategoryId {
            
        } else {
            repo.getCategories { [weak self](response) in
                guard let strongSelf = self else { return }
                
                switch response {
                case .success(let result):
                    if let categories = result.categories {
                        strongSelf.categories = categories
                    }
                    strongSelf.delegate?.didReceiveResponse()
                case.failure:
                    strongSelf.delegate?.didFailed()
                }
            }
        }
    }
}
