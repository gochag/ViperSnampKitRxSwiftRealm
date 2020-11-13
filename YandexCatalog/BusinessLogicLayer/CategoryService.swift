//
//  CategoryService.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 09.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RxSwift

protocol CategoryServiceProtocol {
    func categories() -> Observable<Result<[Category]?, Error>>
    func categoriesByParent(_ category:Category) -> Observable<Result<[Category]?, Error>>
    func deleteAll() -> Observable<Void>
}

enum RequestError: Error {
    case unknown
}

class CategoryService : CategoryServiceProtocol{
  
    let networkService:NetworkService
    let repository:RealmRepository<CategoryObject>
    
    init(_ networkService:NetworkService,_ repository:RealmRepository<CategoryObject>) {
        self.networkService = networkService
        self.repository = repository
    }
    
    /*
     При старте приложения проверяется на запись в БД.
     Если записей нет. Тогда делаю запрос к сети и сохраняю в БД.
     */
    func categories() -> Observable<Result<[Category]?, Error>> {
        let network = self.networkService.getCategory().observeOn(MainScheduler.instance)
            
        
        
        return repository.fetchAllByParent(nil)
            .flatMap{ category -> Observable<Result<[Category]?, Error>> in
                if category.isEmpty {
                    return network.flatMap{self.saveCategory($0)}
                } else {
                    return Observable.just(Result.success(category))
                }
        }
    }
    
    
    /*
     В объектах Category и CategoryObject указывается название родителя.
     При запросе к БД производится поиск детей по родителю.
     */
    func categoriesByParent(_ category: Category) -> Observable<Result<[Category]?, Error>> {
        return repository.fetchAllByParent(category.title).map{Result.success($0)}
    }
    
    func deleteAll() -> Observable<Void> {
        return repository.deleteAll()
    }
    
    private func checkResult(_ result:Result<[Category]?, Error>) -> [Category]?{
        switch(result){
        case Result.success( let value):
            return value
        case Result.failure(_):
            return nil
        }
    }
    
    /*
     Сохраняем все категории в Realm
     */
    private func saveCategory(_ result:Result<[Category], Error>) -> Observable<Result<[Category], Error>>{
        guard let list = checkResult(result) else { return Observable.just(Result.failure(RequestError.unknown))}
        let category = prepareCategory(category: list)
        return repository.save(items: category)
            .flatMap{Observable.just(Result.success(list))
        }
    }
    
    /*
     Родительские и дочерние категрии добавляю в коллекцию для сохранения в Realm
     */
    private func prepareCategory(category:[Category]) -> [Category]{
        let list = category.reduce(into: [Category]()) { (result, cat) in
            result.append(cat)
            result +=  getCategory(category: cat)
        }
        return list
    }
    
    /*
     Проверка дочерних категорий. В этом методе есть рекурсия.
     */
    private func getCategory(category:Category)->[Category]{
        var categoryResult = [Category]()
        
        if let subs = category.subs {
            subs.forEach{
                var cat = $0
                cat.parent = category.title
                categoryResult.append(cat)
                if cat.subs != nil{
                    categoryResult += getCategory(category:$0)
                }
            }
        }
        return categoryResult
    }
}
