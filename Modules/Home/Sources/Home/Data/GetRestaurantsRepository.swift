//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import RxSwift
import Foundation

public struct GetRestaurantsRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
RemoteDataSource.Response == [RestaurantResponse],
Transformer.Response == [RestaurantResponse],
Transformer.Domain == [RestaurantDomainModel]
{


    public typealias Request = Any
    public typealias Response = [RestaurantDomainModel]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    
    public func execute(request: Request?) -> RxSwift.Observable<[RestaurantDomainModel]> {
        return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToDomain(response: $0) }

    }
    
}
