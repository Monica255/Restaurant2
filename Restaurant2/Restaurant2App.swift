//
//  Restaurant2App.swift
//  Restaurant2
//
//  Created by Monica Sucianto on 10/01/24.
//


import SwiftUI
import Home
import Core
import Detail
import Favorite

let restaurantUseCase: Interactor<
  Any,
  [RestaurantDomainModel],
  GetRestaurantsRepository<
    GetRestaurantsRemoteDataSource,
    RestaurantTransformer>
> = Injection.init().provideRestaurant()

let favoriteUseCase: Interactor<
  Any,
  [RestaurantDomainModel],
  GetFavoriteRepository<
    GetFavoriteLocaleDataSource,
    FavoriteTransformer>
> = Injection.init().provideFavorite()

@main
struct Restaurant2: App {
    

    let homePresenter = GetListPresenter(useCase: restaurantUseCase)
    let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
