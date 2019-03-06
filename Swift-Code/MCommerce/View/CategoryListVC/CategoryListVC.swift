//
//  ThreadViewController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class CategoryListVC: BaseViewController {
    
    lazy var viewModel = CategoryViewModel.init(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch category from server
        viewModel.getCategories()
    }
}

extension CategoryListVC: CategoryModelDelegate {

    func didReceiveResponse() {
        
    }
    
    func didFailed() {
        
    }
}
