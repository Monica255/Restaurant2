//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import RxSwift

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
