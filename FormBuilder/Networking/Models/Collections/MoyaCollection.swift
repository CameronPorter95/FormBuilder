//
//  MoyaCollection.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 2/09/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Cache

class MoyaCollection<T>: AsyncCollection, RefreshObservable {
  typealias Element = T
  
  weak var refreshObserver: RefreshObserver?
  var cache = [T]()
  var cacheFilter: (T) -> Bool = { _ in return true }
  var cacheSort: (T, T) -> Bool = { _,_  in return false }
  var isLoading = false
  
  private let futureGenerator: () -> MoyaFuture<[T]>
  
  init(futureGenerator: @escaping () -> MoyaFuture<[T]>) {
    self.futureGenerator = futureGenerator
  }
  
  @discardableResult func refresh() -> MoyaFuture<[T]> {
    isLoading = true
    return futureGenerator()
      .map { (r: [T]) in
        self.set(sequence: r)
        return self.cache
    }
  }
  
  func set(sequence: [T]) {
    isLoading = false
    cache = sequence.filter(cacheFilter).sorted(by: cacheSort)
    refreshObserver?.refreshed()
  }
}
