//
//  RealmRepository.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype EntityType
    
    func save(items: [EntityType]) -> Observable<Void>
    
    func update()
    
    func deleteAll() -> Observable<Void>
    
    func fetchAll() -> Observable<[EntityType]>
    
    func fetchAllByParent(_ title: String?) -> Observable<[EntityType]>
}
