//
//  CategoryInteractor.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RxSwift

class CategoryInteractor: CategoryInteractorProtocol{
    
    let categoryService:CategoryServiceProtocol
    var presenter:CategoryInteractorResultProtocol?
    
    let disposeBag = DisposeBag()
    
    init(categoryService:CategoryServiceProtocol) {
        self.categoryService = categoryService
    }
    
    func loadCategory(){
        categoryService.categories()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] categories in
                self?.presenter?.loadedCategory(categories)
            },onError: nil).disposed(by: disposeBag)
    }
    
    func loadSelectedCategory(_ category: Category) {
        categoryService.categoriesByParent(category)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] categories in
                self?.presenter?.loadedCategory(categories)
            },onError: nil).disposed(by: disposeBag)
    }
    
    func deleteAll() {
        categoryService.deleteAll()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                self?.presenter?.loadedCategory(Result.success([Category]()))
            },onError: nil).disposed(by: disposeBag)
    }
    
}
