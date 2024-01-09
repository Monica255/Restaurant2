//
//  FavoriteView.swift
//  RestaurantApp
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI
import SimpleToast
import Home
import Favorite
import Core

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, RestaurantDomainModel, Interactor<Any, [RestaurantDomainModel], GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    
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
            .navigationTitle("Favorites")
            .onAppear{
                self.presenter.getList(request: nil )
                print(self.presenter.list)
            }
        }
    }
}

//#Preview {
//    FavoriteView()
//}
