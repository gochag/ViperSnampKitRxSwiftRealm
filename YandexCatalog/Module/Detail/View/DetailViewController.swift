//
//  DetailViewController.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 08.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController:BaseViewController, DetailViewInput{
    var titleLabel = UILabel()
    
    var presenter:DetailViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
    }
    
    func setupTitle(){
        self.view.addSubview(titleLabel)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func loadData(category: Category) {
        titleLabel.text = category.title
    }
}
