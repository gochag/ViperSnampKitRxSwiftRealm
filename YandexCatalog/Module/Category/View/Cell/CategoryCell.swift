//
//  CategoryCell.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import SnapKit

class CategoryCell:UITableViewCell{
    
    public static let id = "CategoryCell"
    private let firstLetter = FirstLetter()
    private let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupFistLetter()
        setupTitle()
    }
    
    private func setupFistLetter(){
        self.addSubview(firstLetter)

        firstLetter.snp.makeConstraints{
            $0.left.top.equalTo(16)
            $0.bottom.equalTo(-16)
            $0.right.equalTo(firstLetter.snp.left).offset(firstLetter.intrinsicContentSize.width)
        }
    }
    
    private func setupTitle(){
        self.addSubview(title)
        
        self.title.numberOfLines = 1
        self.title.textColor = .black
        
        self.title.snp.makeConstraints{
            $0.left.equalTo(firstLetter.snp.right).offset(16)
            $0.right.equalTo(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    public func updateTitle(category:Category){
        title.text = category.title
        firstLetter.updateView(category.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- FirstLetter
class FirstLetter:UIView{
    
    private let widthView:CGFloat = 45.0
    private let heightView:CGFloat = 45.0
    private let label = UILabel()
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: widthView, height: heightView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .circleViewColor
        
        self.layer.cornerRadius = widthView/2
        setupFirstLabel()
    }
    
    private func setupFirstLabel(){
        addSubview(label)
        label.textColor = .white
        label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    public func updateView(_ string:String){
        let index = string.startIndex
        label.text = String(string[index]).uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
