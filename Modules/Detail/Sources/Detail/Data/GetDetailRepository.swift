//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import RxSwift
import Foundation


public struct GetDetailRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
RemoteDataSource.Response == DetailResponse,
RemoteDataSource.Request == String,
Transformer.Response == DetailResponse,
Transformer.Domain == DetailDomainModel
{

    public typealias Request = String
    public typealias Response = DetailDomainModel
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    
    public func execute(request: String?) -> Observable<DetailDomainModel> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(response: $0) }

    }
    
}

