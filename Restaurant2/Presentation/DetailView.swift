//
//  DetailView.swift
//  Restaurant
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI
import Detail
import Core
import SimpleToast
import Favorite
import Home
struct DetailView: View {
    
    @EnvironmentObject var detailPresenter: GetPresenter<String, DetailDomainModel, Interactor<String, DetailDomainModel, GetDetailRepository<GetDetailRemotelDataSource, DetailTransformer>>,Interactor<DetailDomainModel, Bool, AddFavoriteRepository<GetFavoriteLocaleDataSource, DetailFavoriteTransformer>>, Interactor<String, Bool,       DeleteFavoriteRepository<GetFavoriteLocaleDataSource>>,Interactor<String, Bool, GetStausFavoriteRepository<GetFavoriteLocaleDataSource, DetailFavoriteTransformer>>>
    
//    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @State var showToast: Bool = false
    private let toastOptions = SimpleToastOptions(
        hideAfter: 2
    )
    
    
    let resId: String
    @State var isLove: Bool = false
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack(alignment:.leading, spacing: 15){
                if let detail = detailPresenter.restaurant, !detailPresenter.isLoading {
                    OnlineImage2(url: detail.imageURL)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(detail.categories,id: \.self){cat in
                                CategoryCell(cat: cat)
                            }
                        }
                    }.padding(.horizontal, 15)
                    HStack{
                        VStack(alignment:.leading,spacing:10){
                            HStack{
                                LoveButton(presenter: detailPresenter, isLove: $isLove,res: detail, showToast: $showToast)
                                Text(detail.name).font(.title3).fontWeight(.semibold)
                            }
                            Text("City: \(detail.city)").fontWeight(.light)
                            
                        }
                        Spacer()
                        VStack(alignment:.center,spacing:10){
                            Image(systemName: "star.fill").foregroundColor(.darkGreen)
                            Text(String(format: "%.2f", detail.rating))
                            
                        }
                    }.padding(.horizontal, 15)
                    Text(detail.description).padding(.horizontal, 15)
                        .fontWeight(.ultraLight)
                    Text("Location: ").fontWeight(.semibold).padding(.horizontal, 15)
                    Text(detail.address ).fontWeight(.light).padding(.horizontal, 15)
                }else{
                    Text("Loading data")
                }
            }.onAppear{
                self.detailPresenter.getData(request: resId)
                detailPresenter.isFavorite(id: resId)
                isLove = detailPresenter.isFavorite
        
            }
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Label(detailPresenter.message, systemImage: "info.circle.fill")
                    .padding()
                    .background(Color.darkGreen.opacity(0.8))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
            }
            
        }
    }
}

struct CategoryCell: View {
    var cat: CategoriesDomainModel
    var body: some View {
        Text(cat.name).fontWeight(.light).padding(.horizontal, 10).overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.secondary, lineWidth: 1)
        ).foregroundColor(.darkGreen)
        
    }
}

struct LoveButton: View {
    let presenter: GetPresenter<String, DetailDomainModel, Interactor<String, DetailDomainModel, GetDetailRepository<GetDetailRemotelDataSource, DetailTransformer>>,Interactor<DetailDomainModel, Bool, AddFavoriteRepository<GetFavoriteLocaleDataSource, DetailFavoriteTransformer>>, Interactor<String, Bool,       DeleteFavoriteRepository<GetFavoriteLocaleDataSource>>,Interactor<String, Bool, GetStausFavoriteRepository<GetFavoriteLocaleDataSource, DetailFavoriteTransformer>>>
    @Binding var isLove: Bool
    let res: DetailDomainModel
    @Binding var showToast: Bool
    var body: some View {
        Button(action: {
            self.isLove.toggle()
            if isLove {
                presenter.favRestaurant(res: res)
            } else {
                presenter.deleteRestaurant(id: res.id)
            }
            showToast =  presenter.showToast
        }) {
            Image(systemName: isLove ? "heart.fill" : "heart")
        }.foregroundColor(.darkGreen)
        
    }
}


struct OnlineImage2:View {
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
                            .frame(width: UIScreen.main.bounds.size.width, height: 300)
                            .background(Color.white)
                            .clipped()
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        .background(Color.white)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        .background(Color.gray)                        .clipped()
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        .background(Color.gray)
                        .clipped()
                }
            }
        }
    }
}
//#Preview {
//    DetailView()
//}
