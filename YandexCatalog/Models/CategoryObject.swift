//
//  Category.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import RealmSwift

class CategoryObject:Object,  RealmEntity{
    
    typealias EntityType = Category
    
    @objc dynamic var parentCategory:String? = nil
    @objc dynamic var id:Int = 0
    @objc dynamic var title:String = ""
    @objc dynamic var child = false

    convenience required init(entity: EntityType){
        self.init()
        self.id = entity.id ?? 0
        self.title = entity.title
        self.parentCategory = entity.parent
        self.child = entity.subs != nil
    }
    
    var plainObject: Category{
        return Category(id: id, title: title, subs: child ? [Category](): nil, parent: parentCategory)
    }
    
    /*
     Ключ использую по тайтлу, так как не у всех объектов есть id
     */
    override static func primaryKey() -> String? {
        return "title"
    }
}
