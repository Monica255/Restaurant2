//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation
import RealmSwift

public class RestaurantFavEntity: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var pictureId: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

