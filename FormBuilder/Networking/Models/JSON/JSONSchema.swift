//
//  JSONSchema.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 31/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONSchema<T: SchemaBranchDefinition>: JsonStructure {
  ///The raw unmapped json
  var json: JSON?
  ///The root branch of this JSONSchema
  var root: SchemaBranchDefinition!
  
  required init(_ json: JSON) {
    let schema = json["JSONSchema"]
    self.json = schema
    root = T.init(json: schema)
  }
}

extension JSON {
  func parse<T: SchemaBranch>(as type: T.Type) -> [String: T]? { //TODO how to pass as non dictionary aka SchemaRoot
    //If the desired type is a property then we must determine the type of property by looking ahead at the type given in json
    if type is SchemaProperty.Type {
      var properties: [String: SchemaProperty] = [:]
      for (name, json) in self {
        let branch = SchemaBranch.init(json: json)
        switch branch.type {
        case SchemaBranchType.object?:
          properties[name] = SchemaProperty.init(json: json)
        case SchemaBranchType.string?:
          properties[name] = SchemaProperty.init(json: json)
        case SchemaBranchType.array?:
          properties[name] = SchemaProperty.init(json: json) //TODO create SchemaArrayProperty class
        case SchemaBranchType.remote?:
          properties[name] = SchemaRemoteProperty.init(json: json)
        case .none:
          properties[name] = SchemaProperty.init(json: json)
          print("Couldn't find a schema branch of type \(json["type"].stringValue), defaulting to base property")
        } //TODO if passing as a subset of SchemaProperty, fail if not all values are able to pass as that subset
      }
      return properties as? [String : T]
    }
    return nil
  }
}
