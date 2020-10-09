//
//  Catgory.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 08.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

struct Category:Decodable{
    let id: Int?
    let title: String
    let subs:[Category]?
    var parent:String?
}

extension Category: Entity {

    typealias RealmEntityType = CategoryObject

    var modelObject: CategoryObject {
        return CategoryObject(entity: self)
    }
}
