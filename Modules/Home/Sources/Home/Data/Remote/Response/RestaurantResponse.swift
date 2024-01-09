//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation

public struct ListResponse: Decodable{
    let error: Bool
    let message: String
    let count: Int
    let restaurants: [RestaurantResponse]
    
}

public struct RestaurantResponse: Identifiable, Decodable{
    public let id: String
    let name: String
    let description: String
    let city: String
    let pictureId: String
    let rating: Double
    
}
