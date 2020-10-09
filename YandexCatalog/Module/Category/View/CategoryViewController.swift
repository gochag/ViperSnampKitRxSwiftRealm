//
//  ViewController.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 06.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift


class CategoryViewController: BaseViewController, CategoryView {
    
    //MARK:- Variable
    var presenter:CategoryPresenterProtocol?
    
    private let tableView:UITableView = UITableView()
    private let updatePanelView = UIView()
    private let updateStackView = UIStackView()
    
    private var categoryVariable = BehaviorRelay(value: [Category]())
    var disposeBag = DisposeBag()
    
    let buttoms = ["Load", "Delete All"]
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTitle()
        setupBottomPanelView()
        setupTableView()
        prepareTableView()
        presenter?.loadCategory()
    }
    
    
    //MARK:- Setup View
    private func setupViewTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Category";
    }
    
    private func setupTableView(){
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = .backgroundColor
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 77, bottom: 0, right: 0)
        tableView.separatorColor = .seporatorColor
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.id)
        
        tableView.tableFooterView = UIView()
        
        /* Тут использую SnapKit */
        tableView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(updatePanelView.snp.top)
        }
    }
    
    private func prepareTableView(){
        /* Тут создаю TableView */
          categoryVariable.asObservable()
              .bind(to: tableView.rx.items(cellIdentifier: CategoryCell.id)){row,item,cell in
                  let cell = cell as! CategoryCell
                  cell.updateTitle(category:item)
          }.disposed(by: disposeBag)
          
          tableView.rx.modelSelected(Category.self).subscribe(onNext: { category in
              self.presenter?.didSelectCategory(category)
          }).disposed(by: disposeBag)
    }
    
    func setupBottomPanelView(){
        //View
        self.view.addSubview(updatePanelView)
        updatePanelView.backgroundColor = .updatePanelColor
        updatePanelView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        //Button
        updateStackView.axis = .horizontal
        updateStackView.alignment = .center
        updateStackView.distribution = .fillEqually
        updatePanelView.addSubview(updateStackView)
        
        updateStackView.snp.makeConstraints{
            $0.left.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        
        buttoms.enumerated().forEach { index, item in
            let button = UIButton()
            button.tag = index
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitle(item, for: .normal)
            button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
            updateStackView.addArrangedSubview(button)
        }
    }
    
    //MARK:- CategoryView
    
    func updateTitle(_ category: Category) {
        navigationItem.title = category.title
    }
    
    func loadCategory(_ category: [Category]) {
        categoryVariable.accept(category)
    }

    //MARK:- Selectors
    
    @objc func updateButtonPressed(button:UIButton){
        switch button.tag {
        case 0:
            presenter?.loadCategory()
        default:
            presenter?.removeAll()
       
        }
        
    }
}
