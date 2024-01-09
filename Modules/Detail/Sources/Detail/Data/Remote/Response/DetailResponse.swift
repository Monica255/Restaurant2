//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//


import Foundation

struct DetailResponses: Decodable{
    let error: Bool
    let message: String
    let restaurant: DetailResponse
}

public struct DetailResponse: Identifiable, Decodable{
    public let id: String
    let name: String
    let description: String
    let city: String
    let address: String
    let pictureId: String
    let categories: [CategoriesResponse]
    let rating: Double

}


struct CategoriesResponse: Decodable {
    let name: String
}
