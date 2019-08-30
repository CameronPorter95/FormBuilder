//
//  SchemaDelegate.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 28/08/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya

protocol SchemaDelegate: class {
  //Get JSON
  func getSchemaDidBegin()
  func getSchemaDidSucceed(schema: JSONSchema<SchemaRoot>)
  func getSchemaDidFail(error: MoyaError)
}

extension SchemaDelegate {
  //Get JSON
  func getSchemaDidBegin() { }
  func getSchemaDidSucceed(schema: JSONSchema<SchemaRoot>) { }
  func getSchemaDidFail(error: MoyaError) { }
}
