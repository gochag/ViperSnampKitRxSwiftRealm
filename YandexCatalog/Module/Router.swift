//
//  Router.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController : UINavigationController? { get set }
    var builder:Builder? {get set}
}

protocol RouterProtocol:RouterMain {
    func initViewController()
    func showCategory(_ category:Category)
    func showDetail(_ category:Category)
}

class Router:RouterProtocol{
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initViewController() {
        if let navigationController = navigationController{
            guard let controller = builder?.createCategoryModule(router: self, category: nil) else {return }
            navigationController.viewControllers = [controller]
        }
    }
    
    func showCategory(_ category: Category) {
        if let navigationController = navigationController{
            guard let controller = builder?.createCategoryModule(router: self, category: category) else {return }
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func showDetail(_ category: Category) {
        if let navigationController = navigationController{
            guard let controller = builder?.createDetailView(router: self, category: category) else {return }
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
