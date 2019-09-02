//
//  RecipientProvider.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 2/09/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class RecipientProvider {
  private weak var provider: BackendProvider!
  var delegates: [RecipientDelegate] = []
  var recipients: RecipientCollection?
  
  init(provider: BackendProvider) {
    self.provider = provider
    self.recipients = RecipientCollection(provider: provider)
  }
  
  @discardableResult func getRecipients() -> MoyaFuture<[Recipient]> {
    delegates.forEach { $0.getRecipientsDidBegin() }
    return (recipients?.refresh()
    .onSuccess { (recipients: [Recipient]) in
      self.delegates.forEach { $0.getRecipientsDidSucceed(recipients: recipients) }
    }.onFailure { error in
      self.delegates.forEach { $0.getRecipientsDidFail(error: error) }
    })!
  }
}
