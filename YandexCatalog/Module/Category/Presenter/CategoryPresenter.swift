//
//  CategoryPresenter.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class CategoryPresenter: CategoryPresenterProtocol,CategoryInteractorResultProtocol{
 
    let categoryView:CategoryView
    let interactor:CategoryInteractorProtocol
    let router:RouterProtocol
    let category:Category?
    
    init(categoryView:CategoryViewController, interactor:CategoryInteractor, router: RouterProtocol, category:Category?) {
        self.categoryView = categoryView
        self.interactor = interactor
        self.router = router
        self.category = category
    }
    
    func loadCategory() {
        if let c = category {
            categoryView.updateTitle(c)
            interactor.loadSelectedCategory(c)
        }else{
            interactor.loadCategory()
        }
    }
    
    func loadedCategory(_ result: Result<[Category]?, Error>) {
        switch result {
        case Result.success(let category):
            categoryView.loadCategory(category!)
        case Result.failure(let error):
            print(error)
        }
    }
    
    func removeAll(){
        interactor.deleteAll()
    }
    
    func didSelectCategory(_ category: Category) {
        if category.subs != nil{
            router.showCategory(category)
        }else{
            router.showDetail(category)
        }
    }
}
