//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import Home
import Detail

public struct DetailFavoriteTransformer: Mapper{
    
    public typealias Response = Any
    public typealias Entity = RestaurantFavEntity
    public typealias Domain = DetailDomainModel
    
    public init() {}
    
    
    public func transformDomainToEntity(domain: Domain) -> Entity {
        let data = RestaurantFavEntity()
        data.id =  domain.id
        data.name =  domain.name
        data.city =  domain.city
        data.pictureId = domain.pictureId
        return data
    }
    
    public func transformResponseToDomain(response: Response) -> Domain {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: Entity) -> Domain {
        fatalError()
    }
    
}
