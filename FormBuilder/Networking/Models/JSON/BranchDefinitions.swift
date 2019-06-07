//
//  SchemaBranch.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 31/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SchemaBranchDefinition {
  ///Initialiser that maps a json object to the schema branch
  init(json: JSON)
  ///Describes what this branch of the schema is
  var description: String? { get }
  ///The data type of this branch of the json
  var type: SchemaBranchType? { get }
  ///The name of this branch
  var title: String? { get }
  ///The fields contained in this branch of the schema
  var properties: [String:SchemaPropertyDefinition]? { get }
  ///An array of properties required by the data using this schema
  var required: [String]? { get }
}

protocol SchemaRootDefinition: SchemaBranchDefinition {
  ///A url to the rules this schema uses
  var schema: String? { get }
  ///A URI for the schema, and the base URI that other URI references within the schema are resolved against.
  var id: String? { get }
}

protocol SchemaPropertyDefinition: SchemaBranchDefinition {
  ///The maximum value of this property
  var maximum: Int? { get }
  ///The minimum value of this property
  var minimum: Int? { get }
}

protocol SchemaRemotePropertyDefinition: SchemaPropertyDefinition {
  ///A reference to another schema
  var url: String? { get }
  ///A JSONPath expression used to get the value of the schema property at RemoteProperty.url
  var valuePath: String? { get }
  ///A JSONPath expression used to get the name of the schema property at RemoteProperty.url
  var namePath: String? { get }
}

protocol SchemaArrayPropertyDefinition: SchemaPropertyDefinition {
  ///The elements in this array property
  var items: [SchemaBranchDefinition]? { get }
  ///The maximum length of the array
  override var maximum: Int? { get }
  ///The minimum length of the array
  override var minimum: Int? { get }
}

enum SchemaBranchType: String {
  case object
  case string
  case array
  case remote
}

extension SchemaBranchDefinition {
  func checkCompatibility(json: JSON, keys: [String]? = nil) {
    guard let keys = keys else { return }
    let filtered = json.dictionaryValue.keys.filter({ //The base of each branch should be a dictionary
      return keys.contains($0)
    })
    
    if filtered.count < json.count {
      let difference = Set(json.dictionaryValue.keys).subtracting(Set(filtered))
      print("There is an incompatibility on: \(String(describing: self)) on these keys: \(difference)") //TODO throw an error here and log to crashlytics
    }
  }
}
