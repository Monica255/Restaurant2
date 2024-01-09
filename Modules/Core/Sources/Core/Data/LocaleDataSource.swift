//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> Observable<[Response]>
    func add(entities: Response) -> Observable<Bool>
    func delete(id: String) -> Observable<Bool>
    func getStatus(id: String) -> Observable<Bool>
}
