//
//  JSONSchema.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 31/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

class JSONSchema<T: SchemaBranchDefinition> {
  ///The raw unmapped json
  var json: JSON!
  ///The root branch of this JSONSchema
  var root: SchemaBranchDefinition!
  
  init(json: JSON) {
    self.json = json
    self.root = T.init(json: json)
    print((root as! SchemaRoot).required!)
  }
}

extension JSON {
//  func parse<T: SchemaBranchDefinition>() -> [String: T] {
//    
//  }
}
