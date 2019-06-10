//
//  JSONCollection.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class JSONCollection: RefreshObservable {
  private let futureGenerator: () -> MoyaFuture<Response>
  
  weak var refreshObserver: RefreshObserver?
  var json = JSON()
  var isLoading = false
  
  init(futureGenerator: @escaping () -> MoyaFuture<Response>) {
    self.futureGenerator = futureGenerator
  }
  
  @discardableResult func refresh() -> MoyaFuture<JSON> {
    isLoading = true
    return futureGenerator()
    .map { (r: Response) in
      do {
        self.set(sequence: try JSON(data: r.data))
      } catch {
        print("Failed to map to json")
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

