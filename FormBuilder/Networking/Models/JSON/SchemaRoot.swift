//
//  SchemaRoot.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

class SchemaRoot: SchemaBranch, SchemaRootDefinition {
  var schema: String?
  var id: String?
  
  required init(json: JSON) {
    super.init(json: json, check: true)
    for property in PropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
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
  
  func mapJSONToProperty(json: JSON, key: PropertyKey) {
    switch key {
    case .schema:
      schema = json[key.rawValue] as? String
    case .id:
      id = json[key.rawValue] as? String
    default:
      ()
    }
  }
}

