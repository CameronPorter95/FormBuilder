//
//  Errors.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 12/08/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct AlertError: Swift.Error {
  var title: String
  var message: String?
  var code: Int?
  
  init(title: String, message: String? = nil, code: Int? = nil) {
    self.title = title
    self.message = message
    self.code = code
  }
}
