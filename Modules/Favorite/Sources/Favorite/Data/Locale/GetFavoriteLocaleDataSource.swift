//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation
import Core
import RxSwift
import RealmSwift

public struct GetFavoriteLocaleDataSource: LocaleDataSource{
    public typealias Request = Any
    public typealias Response = RestaurantFavEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func getStatus(id: String) -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            do {
                if _realm.object(ofType: RestaurantFavEntity.self, forPrimaryKey: id) != nil {
                    try _realm.write {
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }

            return Disposables.create()
        }
    }
    
    public func list(request: Any?) -> Observable<[RestaurantFavEntity]> {
        return Observable<[RestaurantFavEntity]>.create { observer in
            do{
                let restaurants: Results<RestaurantFavEntity> = {
                    _realm.objects(RestaurantFavEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                observer.onNext(restaurants.toArray(ofType: RestaurantFavEntity.self))
                observer.onCompleted()

            }catch{
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    public func add(entities: Response) -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            do {
                try _realm.write {
                    _realm.add(entities, update: .all)
                    observer.onNext(true)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    public func delete(id: String) -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            do {
                if let restaurantToDelete = _realm.object(ofType: RestaurantFavEntity.self, forPrimaryKey: id) {
                    try _realm.write {
                        _realm.delete(restaurantToDelete)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    
}

