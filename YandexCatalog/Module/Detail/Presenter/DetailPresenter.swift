//
//  DetailPresenter.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 08.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class DetailPresenter:DetailViewOutput, DetailInteractorOutput{
    
    let view:DetailViewInput
    let interactor:DetailInteractorIntput
    let router:RouterProtocol
    let category:Category
    
    init(view:DetailViewInput,interactor:DetailInteractorIntput, router:RouterProtocol, category:Category) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.category = category
        
        view.loadData(category: category)
    }
}
