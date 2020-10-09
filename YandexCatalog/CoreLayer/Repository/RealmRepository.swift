//
//  RealmRepository.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 08.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum RepositoryError: Error {
    case castError
    case createError
}

class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity{
    
    typealias RealmEntityType = T
    
    private let realm: Realm
    
    init() throws {
        self.realm = try Realm()
    }
    
    func save(items: [Category]) -> Observable<Void>{
        return Observable.create{ [realm] observer -> Disposable in
            do {
                try realm.write {
                    let models = items.compactMap { $0.modelObject as? T }
                    realm.add(models, update: Realm.UpdatePolicy.all)
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func update() {
        
    }
    
    func deleteAll() -> Observable<Void> {
        return Observable.create{ [realm] observer -> Disposable in
            do {
                try realm.write {
                    realm.delete(realm.objects(T.self))
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchAll() -> Observable<[Category]> {
        return Observable.create { [realm] observer -> Disposable in
            let results: [Category] = realm.objects(CategoryObject.self).compactMap {$0.plainObject}
            observer.onNext(results)
            observer.onCompleted()
            return Disposables.create()
        }
        
    }
    
    func fetchAllByParent(_ title: String?) -> Observable<[Category]>  {
        return Observable.create { [realm] observer -> Disposable in
            let results: [Category] = realm.objects(CategoryObject.self).filter{$0.parentCategory == title}.compactMap {$0.plainObject}
            observer.onNext(results)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
