//
//  SchemaRemoteProperty.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

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
    case .maximum:
      maximum = json[key.rawValue] as? Int
    case .minimum:
      minimum = json[key.rawValue] as? Int
    default:
      ()
    }
  }
}
