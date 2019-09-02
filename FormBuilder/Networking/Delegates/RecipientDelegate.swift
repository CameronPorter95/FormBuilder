//
//  RecipientDelegate.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 2/09/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya

protocol RecipientDelegate: class {
  //Get Recipient
  func getRecipientDidBegin()
  func getRecipientDidSucceed(recipient: Recipient)
  func getRecipientDidFail(error: MoyaError)
  //Get Recipients
  func getRecipientsDidBegin()
  func getRecipientsDidSucceed(recipients: [Recipient])
  func getRecipientsDidFail(error: MoyaError)
}

extension RecipientDelegate {
  //Get Recipient
  func getRecipientDidBegin() { }
  func getRecipientDidSucceed(recipient: Recipient) { }
  func getRecipientDidFail(error: MoyaError) { }
  //Get Recipients
  func getRecipientsDidBegin() { }
  func getRecipientsDidSucceed(recipients: [Recipient]) { }
  func getRecipientsDidFail(error: MoyaError) { }
}
