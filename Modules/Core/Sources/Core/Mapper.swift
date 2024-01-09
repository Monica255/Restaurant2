//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToDomain(response: Response) -> Domain
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
}
