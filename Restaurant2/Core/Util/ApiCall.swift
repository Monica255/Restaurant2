//
//  ApiCall.swift
//  RestaurantApp
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation

struct API {

  static let baseUrl = "https://restaurant-api.dicoding.dev/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Gets: Endpoint {
    case list
    case detail


    public var url: String {
      switch self {
      case .list: return "\(API.baseUrl)list"
      case .detail: return "\(API.baseUrl)/detail/"
      }
    }
  }

}
