//
//  AsyncCollection.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import BrightFutures

/// Represents a delegate observing an entity that can be refreshed
/// (usually a collection).
protocol RefreshObserver: class {
  func refreshed()
}

/// An entity that can notify an observer about refreshes and also can be in
/// the process of having a refresh in progress. Usually is conformed to by
/// `AsyncCollection` implementors.
protocol RefreshObservable {
  /// Indicates whether a refresh is in progress.
  var isLoading: Bool { get }
  
  /// An observer to be notified about refreshes.
  var refreshObserver: RefreshObserver? { get set }
}

/// A protocol for all asynchronous collections to conform to. `AsyncCollection`
/// instance represents elements from some asynchronous source, most of the time
/// it's data coming from a server.
protocol AsyncCollection: Collection {
  /// Error type to be raised when collection operations fail
  associatedtype CollectionError: Error
  
  /// A cache of elements available in this collection. Might not reflect
  /// the actual elements in the asynchronous source backing the collection.
  var cache: [Element] { get }
  
  /// Refreshes the collection cache
  /// - Returns: a future with the new caches
  @discardableResult func refresh() -> Future<[Element], CollectionError>
}

/// A protocol extension that automatically adds `Collection` conformance
/// to whatever is conforming to `AsyncCollection`.
extension AsyncCollection {
  func index(after i: Int) -> Int {
    return cache.index(after: i)
  }
  
  var startIndex: Int {
    return cache.startIndex
  }
  
  var endIndex: Int {
    return cache.endIndex
  }
  
  subscript (position: Int) -> Element {
    return cache[position]
  }
}
