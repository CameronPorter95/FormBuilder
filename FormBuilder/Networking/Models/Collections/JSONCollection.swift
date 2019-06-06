//
//  JSONCollection.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya

class JSONCollection: RefreshObservable {
  private let futureGenerator: () -> MoyaFuture<Response>
  
  weak var refreshObserver: RefreshObserver?
  var json = JSON()
  var isLoading = false
  
  init(futureGenerator: @escaping () -> MoyaFuture<Response>) {
    self.futureGenerator = futureGenerator
  }
  
  @discardableResult func refresh() -> MoyaFuture<JSON>? {
    isLoading = true
    return futureGenerator()
      .map { (r: Response) in
        do {
          let result = try JSONSerialization.jsonObject(with: r.data, options: [])
          guard let json = result as? JSON,
          let data = json["data"] as? JSON else {
            print("failed to map to json dictionary")
            return [:]
          }
          self.set(sequence: data)
        } catch {
          print("failed to map to json dictionary")
        }
        return self.json
    }
  }
  
  func set(sequence: JSON) {
    isLoading = false
    json = sequence
    refreshObserver?.refreshed()
  }
}
