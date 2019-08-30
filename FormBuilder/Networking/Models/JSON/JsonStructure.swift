//
//  JsonStructure.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 28/08/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonStructure {
  var json: JSON? { get set }
  
  init(_ json: JSON)
}

extension JsonStructure {
  var jsonString: String {
    get {
      guard let json = json else { return "" }
      return JSON(json).rawString() ?? ""
    }
  }
  
  mutating func set(_ key: String, _ value: Any) {
    json?[key] = JSON(value)
  }
}
