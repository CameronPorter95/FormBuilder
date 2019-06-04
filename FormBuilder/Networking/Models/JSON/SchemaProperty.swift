//
//  SchemaProperty.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct SchemaProperty: SchemaPropertyDefinition {
  var title: String?
  var maximum: Int?
  var minimum: Int?
  var description: String?
  var type: String?
  var properties: [String : SchemaPropertyDefinition]?
  var required: [String]?
  
  init(json: JSON) {
    for property in PropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
    
    let filtered = json.keys.filter({
      for key in PropertyKey.allCases where key.rawValue == $0 {
        return true
      }
      return false
    })
    
    if filtered.count < json.count {
      print("cannot convert to this json type")
    }
  }
  
  enum PropertyKey: String, CaseIterable {
    case title = "title"
    case maximum = "maximum"
    case minimum = "minimum"
    case description = "description"
    case type = "type"
    case properties = "properties"
    case required = "required"
  }
  
  mutating func mapJSONToProperty(json: JSON, key: PropertyKey) {
    switch key {
    case .title:
      title = json[key.rawValue] as? String
    case .maximum:
      maximum = json[key.rawValue] as? Int
    case .minimum:
      minimum = json[key.rawValue] as? Int
    case .description:
      description = json[key.rawValue] as? String
    case .type:
      type = json[key.rawValue] as? String
    case .properties:
      properties = json[key.rawValue] as? [String : SchemaPropertyDefinition]
    case .required:
      required = json[key.rawValue] as? [String]
    }
  }
}
