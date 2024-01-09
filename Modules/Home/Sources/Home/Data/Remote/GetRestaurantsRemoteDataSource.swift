//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import RxSwift
import Alamofire
import Foundation

public struct GetRestaurantsRemoteDataSource: DataSource{
    public typealias Request = Any
    
    public typealias Response = [RestaurantResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> Observable<[RestaurantResponse]> {
        return Observable<[RestaurantResponse]>.create { observer in
          if let url = URL(string: _endpoint) {
            AF.request(url)
              .validate()
              .responseDecodable(of: ListResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value.restaurants)
                  observer.onCompleted()
                case .failure(let error):
                  observer.onError(error)
                }
              }
          }
          return Disposables.create()
        }
      }
}
