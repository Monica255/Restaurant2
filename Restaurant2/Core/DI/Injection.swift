//
//  Injection.swift
//  RestaurantApp
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation
import RealmSwift
import Core
import Detail
import Home
import Favorite

final class Injection: NSObject{
    
    func provideRestaurant<U: UseCase>() -> U where U.Request == Any, U.Response == [RestaurantDomainModel] {
        let remote = GetRestaurantsRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        let mapper = RestaurantTransformer()
        let repository = GetRestaurantsRepository(
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>() -> U where U.Request == String, U.Response == DetailDomainModel {
        let remote = GetDetailRemotelDataSource(endpoint: Endpoints.Gets.detail.url)
        let mapper = DetailTransformer()
        let repository = GetDetailRepository(
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    private let realm = try? Realm()
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [RestaurantDomainModel]  {
        let locale = GetFavoriteLocaleDataSource(realm: realm!)
        let mapper = FavoriteTransformer()
        let repository = GetFavoriteRepository(
            localeDataSource: locale,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideGetFavorite<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let local = GetFavoriteLocaleDataSource(realm: realm!)
        let mapper = DetailFavoriteTransformer()
        let repository = GetStausFavoriteRepository(
            localeDataSource: local,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideAddFavorite<U: UseCase>() -> U where U.Request == DetailDomainModel, U.Response == Bool {
        let local = GetFavoriteLocaleDataSource(realm: realm!)
        let mapper = DetailFavoriteTransformer()
        let repository = AddFavoriteRepository(
            localeDataSource: local,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideDeleteFavorite<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let local = GetFavoriteLocaleDataSource(realm: realm!)
        let repository = DeleteFavoriteRepository(localeDataSource: local)
        return Interactor(repository: repository) as! U
    }
    
    
    
}
