//
//  SchemaProperty.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchemaProperty: SchemaBranch, SchemaPropertyDefinition {
  var maximum: Int?
  var minimum: Int?
  
  required init(json: JSON) {
    super.init(json: json, keys: PropertyKey.allCases.map({
      $0.rawValue
    }))
    for property in PropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  override init(json: JSON, keys: [String]) {
    super.init(json: json, keys: keys)
    for property in PropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  enum PropertyKey: String, CaseIterable {
    case maximum = "maximum"
    case minimum = "minimum"
    case title = "title"
    case description = "description"
    case type = "type"
    case properties = "properties"
    case required = "required"
  }
  
  func mapJSONToProperty(json: JSON, key: PropertyKey) {
    switch key {
    case .maximum:
      maximum = json[key.rawValue].intValue
    case .minimum:
      minimum = json[key.rawValue].intValue
    default:
      ()
    }
  }
}
