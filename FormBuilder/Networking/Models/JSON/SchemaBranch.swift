//
//  SchemaBranch.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 5/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchemaBranch: SchemaBranchDefinition {
  var description: String?
  var type: SchemaBranchType?
  var title: String?
  var properties: [String : SchemaPropertyDefinition]?
  var required: [String]?
  
  required init(json: JSON) {
    for property in BaseKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  init(json: JSON, keys: [String]) {
    for property in BaseKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
    
    checkCompatibility(json: json, keys: keys)
  }
  
  enum BaseKey: String, CaseIterable {
    case description = "description"
    case type = "type"
    case title = "title"
    case properties = "properties"
    case required = "required"
  }
  
  func mapJSONToProperty(json: JSON, key: BaseKey?) {
    guard let key = key else { return }
    switch key {
    case .description:
      description = json[key.rawValue].stringValue
    case .type:
      type = SchemaBranchType(rawValue: json[key.rawValue].stringValue)
    case .title:
      title = json[key.rawValue].stringValue
    case .properties:
      properties = json[key.rawValue].parse(as: SchemaProperty.self)
    case .required:
      required = json[key.rawValue].arrayObject as? [String]
    }
  }
}
