//
//  HomeView.swift
//  RestaurantApp
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI
import Core
import Home
import Detail
import Favorite

struct HomeView: View {
    @ObservedObject var presenter: GetListPresenter<Any, RestaurantDomainModel, Interactor<Any, [RestaurantDomainModel], GetRestaurantsRepository<GetRestaurantsRemoteDataSource, RestaurantTransformer>>>
    //    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView{
            ZStack{
                if presenter.isLoading{
                    VStack {
                        Text("Loading...")
                        ProgressView()
                    }
                }else{
                    VStack{
                        List(self.presenter.list){res in
                            ListCell(res: res)
                        }
                    }
                }
            }
            .navigationTitle("Restaurants")
            .onAppear{
                if self.presenter.list.count == 0 {
                    self.presenter.getList(request:nil)
                }
            }
        }
    }
}

let detailUseCase: Interactor<
    String,
    DetailDomainModel,
    GetDetailRepository<
        GetDetailRemotelDataSource,
        DetailTransformer>
> = Injection.init().provideDetail()

let addfavUseCase: Interactor<
    DetailDomainModel,
    Bool,
    AddFavoriteRepository<
        GetFavoriteLocaleDataSource,
        DetailFavoriteTransformer>
> = Injection.init().provideAddFavorite()

let deletefavUseCase: Interactor<
    String,
    Bool,
    DeleteFavoriteRepository<
        GetFavoriteLocaleDataSource>
> = Injection.init().provideDeleteFavorite()

let getfavUseCase: Interactor<
    String,
    Bool,
    GetStausFavoriteRepository<
        GetFavoriteLocaleDataSource, DetailFavoriteTransformer>
> = Injection.init().provideGetFavorite()

struct ListCell: View {
    //    let presenter: DetailPresenter
    let detailPresenter = GetPresenter(detailUseCase: detailUseCase, addFavUseCase: addfavUseCase, deleteFavUseCase: deletefavUseCase, getFavUseCase: getfavUseCase)
//    let favoritePresenter = FavoritePresenter(favUseCase: Injection.init().provideFavoriteUseCase())
    
    var res: RestaurantDomainModel
    var body: some View {
        NavigationLink(destination: DetailView(resId: res.id).environmentObject(detailPresenter)){
            HStack{
                OnlineImage(url: res.imageURL)
                VStack(alignment:.leading){
                    Text(res.name).font(.headline).fontWeight(.semibold)
                    Text(res.city).font(.subheadline).fontWeight(.light)
                }
            }
        }
        
    }
}

struct OnlineImage:View {
    let url : URL
    var body: some View {
        HStack{
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack{
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .background(Color.white)
                            .cornerRadius(15)
                            .clipped()
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .background(Color.white)
                        .cornerRadius(15)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .cornerRadius(15)
                        .clipped()
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .cornerRadius(15)
                        .clipped()
                }
            }
            
        }
    }
}

//#Preview {
//    HomeView()
//}
