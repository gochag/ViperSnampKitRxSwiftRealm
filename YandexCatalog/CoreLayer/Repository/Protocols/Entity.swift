//
//  Entity.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 08.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol Entity {
    associatedtype RealmEntityType
    var modelObject: RealmEntityType { get }
}

protocol RealmEntity {
    associatedtype EntityType
    var plainObject: EntityType { get }
}


