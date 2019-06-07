//
//  JSONDelegate.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 7/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

protocol JSONDelegate: class {
  //Get JSON
  func getJSONDidBegin()
  func getJSONDidSucceed(json: JSON)
  func getJSONDidFail(error: MoyaError)
}

extension JSONDelegate {
  //Get JSON
  func getJSONDidBegin() { }
  func getJSONDidSucceed(json: JSON) { }
  func getJSONDidFail(error: MoyaError) { }
}
