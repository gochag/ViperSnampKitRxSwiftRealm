//
//  CategoryProtocol.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol CategoryView {
    func loadCategory(_ category:[Category])
    func updateTitle(_ category:Category)
}


protocol CategoryPresenterProtocol {
    func didSelectCategory(_ category:Category)
    func loadCategory()
    func removeAll()
}
