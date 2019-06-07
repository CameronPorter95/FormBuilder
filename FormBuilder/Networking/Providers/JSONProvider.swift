//
//  JSONProvider.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 7/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class JSONProvider {
  private weak var provider: BackendProvider!
  var delegates: [JSONDelegate] = []
  
  init(provider: BackendProvider) {
    self.provider = provider
  }
  
  func getJSON(for formID: Int) -> MoyaFuture<JSON> {
    let jsonCollection = JSONCollection {
      self.provider.future(.getForms(id: formID))
    }
    delegates.forEach { $0.getJSONDidBegin() }
    return jsonCollection.refresh()
      .onSuccess { (json: JSON) in
        self.delegates.forEach { $0.getJSONDidSucceed(json: json) }
      }.onFailure { error in
        self.delegates.forEach { $0.getJSONDidFail(error: error) }
      }
  }
}
