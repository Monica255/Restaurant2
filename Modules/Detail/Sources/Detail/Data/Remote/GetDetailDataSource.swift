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

public struct GetDetailRemotelDataSource: DataSource{
    public typealias Request = String
    
    public typealias Response = DetailResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: String?) -> Observable<DetailResponse> {
        return Observable<DetailResponse>.create { observer in
            if let url = URL(string: _endpoint+(request ?? "")) {
            AF.request(url)
              .validate()
              .responseDecodable(of: DetailResponses.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value.restaurant)
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
