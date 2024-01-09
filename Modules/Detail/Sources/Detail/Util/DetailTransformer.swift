//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//
import Core

public struct DetailTransformer: Mapper{
    
    public typealias Response = DetailResponse
    public typealias Entity = Any
    public typealias Domain = DetailDomainModel
    
    public init() {}
    
    public func transformDomainToEntity(domain: Domain) -> Entity {
        fatalError()
    }
    
    
    public func transformEntityToDomain(entity: Entity) -> Domain {
        fatalError()
    }
    
    public func transformResponseToDomain(response: Response) -> Domain {
        return DetailDomainModel(
            id: response.id,
            name: response.name,
            description: response.description,
            city: response.city,
            address: response.address,
            pictureId: response.pictureId,
            categories: mapCategoriesToDomain(input: response.categories),
            rating: response.rating
        )
        
    }
    
    private func mapCategoriesToDomain(input categories: [CategoriesResponse]) -> [CategoriesDomainModel] {
        return categories.map { category in
            let categoryModel = CategoriesDomainModel(
                name: category.name
            )
            return categoryModel
        }
    }
    
}
