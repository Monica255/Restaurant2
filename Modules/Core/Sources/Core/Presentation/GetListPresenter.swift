//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI
import RxSwift
 
@available(iOS 13.0, *)
public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private let disposeBag = DisposeBag()
    
    private let _useCase: Interactor
    
    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getList(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.list = result
            } onError: { error in
                print(error.localizedDescription)
                self.isError = true
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
}
