//
//  CategoryInteractorProtocol.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RxSwift

protocol CategoryInteractorProtocol {    
    func loadCategory()
    func loadSelectedCategory(_ category:Category)
    func deleteAll()
    
}

protocol CategoryInteractorResultProtocol {
    func loadedCategory(_ result:Result<[Category]?, Error>)
}
