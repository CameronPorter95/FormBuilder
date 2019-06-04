//
//  SchemaRoot.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct SchemaRoot: SchemaRootDefinition {
  var schema: String?
  var id: String?
  var description: String?
  var type: String?
  var properties: [String : SchemaPropertyDefinition]?
  var required: [String]?
  
  init(json: JSON) {
    for property in PropertyKey.allCases { //IDEA super.init that takes json and propertykeys
      mapJSONToProperty(json: json, key: property)
    }
    
    let filtered = json.keys.filter({ //TODO move this to an inherited function
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
    case schema = "schema"
    case id = "id"
    case description = "description"
    case type = "type"
    case properties = "properties"
    case required = "required"
  }
  
  mutating func mapJSONToProperty(json: JSON, key: PropertyKey) {
    switch key {
    case .schema:
      schema = json[key.rawValue] as? String
    case .id:
      id = json[key.rawValue] as? String
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

