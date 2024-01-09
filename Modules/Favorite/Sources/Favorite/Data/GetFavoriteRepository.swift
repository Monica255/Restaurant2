//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import RxSwift
import RealmSwift
import Home
import Detail

public struct GetFavoriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
RestaurantLocaleDataSource.Response == RestaurantFavEntity,
Transformer.Entity == [RestaurantFavEntity],
Transformer.Domain == [RestaurantDomainModel]
{
    
    
    public typealias Request = Any
    public typealias Response = [RestaurantDomainModel]
    
    private let _localeDataSource: RestaurantLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: RestaurantLocaleDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
    public func execute(request: Request?) -> Observable<[RestaurantDomainModel]> {
        return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
        
    }
    
}

public struct GetStausFavoriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
RestaurantLocaleDataSource.Response == RestaurantFavEntity,
Transformer.Entity == RestaurantFavEntity,
Transformer.Domain == DetailDomainModel
{
    
    public typealias Request = String
    public typealias Response = Bool
    
    private let _localeDataSource: RestaurantLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: RestaurantLocaleDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    public func execute(request: String?) -> Observable<Bool> {
        return _localeDataSource.getStatus(id: request ?? "")
    }
}

public struct AddFavoriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
RestaurantLocaleDataSource.Response == RestaurantFavEntity,
Transformer.Entity == RestaurantFavEntity,
Transformer.Domain == DetailDomainModel
{
    
    public typealias Request = DetailDomainModel
    public typealias Response = Bool
    
    private let _localeDataSource: RestaurantLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: RestaurantLocaleDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
    public func execute(request: DetailDomainModel?) -> Observable<Bool> {
        return _localeDataSource.add(entities: _mapper.transformDomainToEntity(domain: request!))
    }
    
}

public struct DeleteFavoriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource
>: Repository where
RestaurantLocaleDataSource.Response == RestaurantFavEntity
{
    
    public typealias Request = String
    public typealias Response = Bool
    
    private let _localeDataSource: RestaurantLocaleDataSource
    
    public init(
        localeDataSource: RestaurantLocaleDataSource) {
            _localeDataSource = localeDataSource
            
        }
    
    public func execute(request: String?) -> RxSwift.Observable<Bool> {
        return _localeDataSource.delete(id: request ?? "")
    }
}
