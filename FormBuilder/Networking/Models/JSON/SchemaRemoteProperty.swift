//
//  SchemaRemoteProperty.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchemaRemoteProperty: SchemaProperty, SchemaRemotePropertyDefinition {
  var url: String?
  var valuePath: String?
  var namePath: String?
  
  required init(json: JSON) {
    super.init(json: json, keys: Key.allCases.map({
      $0.rawValue
    }))
    for property in Key.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  enum Key: String, CaseIterable {
    case url = "url"
    case valuePath = "valuePath"
    case namePath = "namePath"
    case maximum = "maximum"
    case minimum = "minimum"
    case title = "title"
    case description = "description"
    case type = "type"
    case properties = "properties"
    case required = "required"
  }
  
  func mapJSONToProperty(json: JSON, key: Key) {
    switch key {
    case .url:
      url = json[key.rawValue].stringValue
    case .valuePath:
      valuePath = json[key.rawValue].stringValue
    case .namePath:
      namePath = json[key.rawValue].stringValue
    default:
      ()
    }
  }
}
