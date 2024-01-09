//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI
import RxSwift


@available(iOS 13.0, *)
public class GetPresenter<Request, Response, DetailInteractor: UseCase, AddFavInteractor: UseCase, DeleteFavInteractor: UseCase, GetFavInteractor: UseCase>: ObservableObject where DetailInteractor.Request == Request, DetailInteractor.Response == Response, AddFavInteractor.Request == Response, AddFavInteractor.Response == Bool, DeleteFavInteractor.Request ==  String, DeleteFavInteractor.Response == Bool, GetFavInteractor.Request ==  String, GetFavInteractor.Response == Bool{
    
    private let disposeBag = DisposeBag()
    
    private let _detailUseCase: DetailInteractor
    private let _addFavUseCase: AddFavInteractor
    private let _deleteFavUseCase: DeleteFavInteractor
    private let _getFavUseCase: GetFavInteractor
    
    @Published public var restaurant: Response? = nil
    @Published public var message: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isFavorite: Bool = false
    @Published public var showToast: Bool = false
    
    public init(detailUseCase: DetailInteractor, addFavUseCase: AddFavInteractor, deleteFavUseCase: DeleteFavInteractor, getFavUseCase: GetFavInteractor) {
        self._detailUseCase = detailUseCase
        self._addFavUseCase = addFavUseCase
        self._deleteFavUseCase = deleteFavUseCase
        self._getFavUseCase = getFavUseCase
    }
    
    public func getData(request: Request?) {
        isLoading = true
        _detailUseCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.restaurant = result
            } onError: { error in
                print("Detail error",error.localizedDescription)
                self.isError = true
                self.message = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    public func isFavorite(id: String){
        isLoading = true
        _getFavUseCase.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = result
            } onError: { error in
                print(error.localizedDescription)
                self.isError = true
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
        
    }
    
    public func favRestaurant(res: Response) {
        isLoading = true
        _addFavUseCase.execute(request: res)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.showToast = true
                if result{
                    self.message = "Added to favorites"
                }else{
                    self.message = "failed to add to favorites"
                }
            } onError: { error in
                print(error.localizedDescription)
                self.message = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    public func deleteRestaurant(id: String) {
        isLoading = true
        _deleteFavUseCase.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.showToast = true
                if result {
                    self.message = "Removed to favorites"
                }else{
                    self.message = "failed to remove from favorites"
                }            } onError: { error in
                    print(error.localizedDescription)
                    self.message = error.localizedDescription
                } onCompleted: {
                    self.isLoading = false
                }.disposed(by: disposeBag)
    }
    
}
