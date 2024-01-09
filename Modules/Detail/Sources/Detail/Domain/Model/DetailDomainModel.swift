//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation

public struct DetailDomainModel: Identifiable, Equatable, Hashable{
    public let id: String
    public let name: String
    public let description: String
    public let city: String
    public let address: String
    public let pictureId: String
    public let categories: [CategoriesDomainModel]
    public let rating: Double
    public var imageURL: URL {
            let baseURL = "https://restaurant-api.dicoding.dev/images/medium/"
            return URL(string: baseURL + pictureId)!
        }


}


public struct CategoriesDomainModel: Equatable , Hashable{
    public let name: String
}
