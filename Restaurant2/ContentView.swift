//
//  ContentView.swift
//  Restaurant2
//
//  Created by Monica Sucianto on 10/01/24.
//


import SwiftUI
import Core
import Home
import Favorite

struct ContentView: View {
    init() {
        let navbar = UINavigationBarAppearance()
        navbar.configureWithOpaqueBackground()
        navbar.backgroundImage = UIImage()
        navbar.backgroundColor = UIColor.clear
        navbar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGreen]
        navbar.titleTextAttributes = [.foregroundColor: UIColor.darkGreen]
        
        let navbar2 = UINavigationBarAppearance()
        navbar2.configureWithOpaqueBackground()
        navbar2.backgroundImage = UIImage()
        navbar2.backgroundColor = UIColor.darkGreen.withAlphaComponent(0.6)
        navbar2.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar2.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navbar2.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = navbar2
        UINavigationBar.appearance().scrollEdgeAppearance = navbar
    }
    
//    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var homePresenter: GetListPresenter<Any, RestaurantDomainModel, Interactor<Any, [RestaurantDomainModel], GetRestaurantsRepository<GetRestaurantsRemoteDataSource, RestaurantTransformer>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<Any, RestaurantDomainModel, Interactor<Any, [RestaurantDomainModel], GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>


    var body: some View {
        TabView{
            HomeView(presenter: homePresenter)
                .tabItem {
                    Label("Restaurants", systemImage: "fork.knife.circle.fill")
                }
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Label("Favorites", systemImage: "heart.circle.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            
        }.accentColor(.darkGreen)
    }
}

#Preview {
    ContentView()
}
