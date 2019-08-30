//
//  FormProvider.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 28/08/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class FormProvider {
  private weak var provider: BackendProvider!
  var delegates: [SchemaDelegate] = []
  
  init(provider: BackendProvider) {
    self.provider = provider
  }
  
  func getSchema(for request: FormRequest) -> MoyaFuture<JSONSchema<SchemaRoot>> {
    delegates.forEach { $0.getSchemaDidBegin() }
    return provider.futureJsonObject(.getForm(for: request), isJsonApi: true)
      .onSuccess { (schema: JSONSchema<SchemaRoot>) in
        self.delegates.forEach { $0.getSchemaDidSucceed(schema: schema) }
      }.onFailure { error in
        self.delegates.forEach { $0.getSchemaDidFail(error: error) }
    }
  }
}
