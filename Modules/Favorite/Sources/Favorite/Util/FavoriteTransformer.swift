//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core
import Home

public struct FavoriteTransformer: Mapper{
    
    public typealias Response = Any
    public typealias Entity = [RestaurantFavEntity]
    public typealias Domain = [RestaurantDomainModel]
    
    public init() {}
    
    
    public func transformEntityToDomain(entity: Entity) -> Domain {
        return entity.map{result in
            let data = RestaurantDomainModel(
                id: result.id,
                name: result.name,
                city: result.city,
                pictureId: result.pictureId
            )
            return data
        }
    }
    
    public func transformResponseToDomain(response: Response) -> Domain {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: Domain) -> Entity {
        fatalError()
    }

}
