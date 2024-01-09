//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation

public struct RestaurantDomainModel: Equatable ,Identifiable{
    public var id: String
    public var name: String
    public var city: String
    public var pictureId: String
    public var imageURL: URL {
            let baseURL = "https://restaurant-api.dicoding.dev/images/medium/"
            return URL(string: baseURL + pictureId)!
        }
    
    public init(id: String, name: String, city: String, pictureId: String) {
        self.id = id
        self.name = name
        self.city = city
        self.pictureId = pictureId
    }
}
