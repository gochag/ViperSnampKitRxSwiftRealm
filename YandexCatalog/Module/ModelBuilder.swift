//
//  ModelBuilder.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 06.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol Builder {
    func createCategoryModule(router:RouterProtocol, category:Category?) -> CategoryViewController
    func createDetailView(router:RouterProtocol, category:Category) -> DetailViewController
}

class ModuleBuilder:Builder{
    
    let networkService = NetworkService()
    let repository:RealmRepository<CategoryObject>
    
    init() {
        self.repository = try! RealmRepository<CategoryObject>()
    }
    
    func createCategoryModule(router:RouterProtocol, category:Category?) -> CategoryViewController {
        let controller = CategoryViewController()
        
        let service = CategoryService( networkService,  repository)
        let interactor = CategoryInteractor(categoryService: service)
        
        let presenter = CategoryPresenter(categoryView: controller, interactor: interactor,
                                          router: router, category:category)
        controller.presenter = presenter
        interactor.presenter = presenter
        
        return controller
    }
    
    func createDetailView(router:RouterProtocol, category:Category) -> DetailViewController{
        let controller = DetailViewController()
        
        let interactor = DetailInteractor()
    
        let presenter = DetailPresenter(view: controller, interactor: interactor,
                                        router: router, category: category)
        
        interactor.presenter = presenter
        controller.presenter = presenter
        
        return controller
    }
    
}
