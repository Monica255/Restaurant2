//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Core

public struct RestaurantTransformer: Mapper{
    
    public typealias Response = [RestaurantResponse]
    public typealias Entity = Any
    public typealias Domain = [RestaurantDomainModel]
    
    public init() {}
    
    public func transformResponseToDomain(response: Response) -> Domain {
        return response.map { response in
            let model = RestaurantDomainModel(
                id: response.id,
                name: response.name,
                city: response.city,
                pictureId: response.pictureId)
            return model
        }
    }
    
    public func transformDomainToEntity(domain: Domain) -> Entity {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: Entity) -> Domain {
        fatalError()
    }
    
    
}
