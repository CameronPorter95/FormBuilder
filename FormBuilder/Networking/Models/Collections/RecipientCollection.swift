//
//  RecipientCollection.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 2/09/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya

class RecipientCollection: MoyaCollection<Recipient> {
   fileprivate weak var provider: BackendProvider!
  
  init(provider: BackendProvider, cache: [Recipient]? = nil,
       cacheFilter: @escaping (Recipient) -> Bool = { _ in return true }, cacheSort: ((Recipient, Recipient) -> Bool)? = nil) {
    self.provider = provider
    super.init {
      provider.futureArray(.getRecipients())
    }
    self.cache = cache ?? []
    self.cacheFilter = cacheFilter
    self.cacheSort = cacheSort ??
    ({
      guard let n0 = $0.name?.lowercased(),
        let n1 = $1.name?.lowercased() else { return true }
      return n0 < n1
    })
  }
  
  @discardableResult override func refresh() -> MoyaFuture<[Recipient]> {
    return super.refresh()
  }
}
