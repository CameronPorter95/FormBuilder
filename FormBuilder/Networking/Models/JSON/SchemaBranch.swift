//
//  SchemaBranch.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 5/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

class SchemaBranch: SchemaBranchDefinition {
  var description: String?
  var type: SchemaBranchType?
  var title: String?
  var properties: [String : SchemaPropertyDefinition]?
  var required: [String]?
  
  required init(json: JSON) {
    for property in BasePropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
  }
  
  init(json: JSON, check: Bool = true) {
    for property in BasePropertyKey.allCases {
      mapJSONToProperty(json: json, key: property)
    }
    
    if check {
      checkCompatibility(json: json, properties: BasePropertyKey.allCases.map({
        $0.rawValue
      }))
    }
  }
  
  enum BasePropertyKey: String, CaseIterable {
    case description = "description"
    case type = "type"
    case title = "title"
    case properties = "properties"
    case required = "required"
  }
  
  func mapJSONToProperty(json: JSON, key: BasePropertyKey?) {
    guard let key = key else { return }
    switch key {
    case .description:
      description = json[key.rawValue] as? String
    case .type:
      type = SchemaBranchType(rawValue: json[key.rawValue] as? String ?? "")
    case .title:
      title = json[key.rawValue] as? String
    case .properties:
      properties = (json[key.rawValue] as? JSON)?.parse(as: SchemaProperty.self)
    case .required:
      required = json[key.rawValue] as? [String]
    
    }
  }
}
