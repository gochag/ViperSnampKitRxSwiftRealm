//
//  NetworkService.swift
//  YandexCatalog
//
//  Created by Tarlan Hekimzade on 07.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func getCategory(completion: @escaping (Result<[Category]?,Error>) -> Void)
    func getCategory() -> Observable<Result<[Category]?,Error>>
}

enum NetworkError:Error{
    case createError
}

class NetworkService:NetworkServiceProtocol{
    
    func getCategory() -> Observable<Result<[Category]?, Error>> {
        return Observable.create{ observer -> Disposable in
            
            let urlString = "https://money.yandex.ru/api/categories-list"
            guard let url = URL(string: urlString) else {
                observer.onNext(.failure(NetworkError.createError))
                observer.onCompleted()
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                     if let error = error {
                        observer.onNext(.failure(error))
                        observer.onCompleted()
                     }
                
                     do{
                        let obj = try JSONDecoder().decode([Category].self, from: data!)
                        observer.onNext(.success(obj))
                        observer.onCompleted()
                     }catch{
                         observer.onNext(.failure(error))
                         observer.onCompleted()
                     }
                
                 }.resume()
            return Disposables.create()
        }
    }
    
    func getCategory(completion: @escaping (Result<[Category]?, Error>) -> Void) {
        let urlString = "https://money.yandex.ru/api/categories-list"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            do{
                let obj = try JSONDecoder().decode([Category].self, from: data!)
                completion(.success(obj))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}
