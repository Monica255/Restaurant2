//
//  File.swift
//  
//
//  Created by Monica Sucianto on 08/01/24.
//

import Foundation
import RealmSwift

extension Results {
  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
