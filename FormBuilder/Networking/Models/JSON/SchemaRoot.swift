//
//  SchemaRoot.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchemaRoot: SchemaBranch, SchemaRootDefinition {
  var schema: String?
  var id: String?
  
  required init(json: JSON) {
    super.init(json: json, keys: RootKey.allCases.map({
      $0.rawValue
    }))
    for property in RootKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  enum RootKey: String, CaseIterable {
    case schema = "schema"
    case id = "id"
    case description = "description"
    case type = "type"
    case title = "title"
    case properties = "properties"
    case required = "required"
  }
  
  func mapJSONToProperty(json: JSON, key: RootKey) {
    switch key {
    case .schema:
      schema = json[key.rawValue].stringValue
    case .id:
      id = json[key.rawValue].stringValue
    default:
      ()
    }
  }
}

