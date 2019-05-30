//
//  BackendResponse.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct BackendResponse<T>: Codable where T: Codable {
  var status: String?
  var code: Int?
  var data: T?
  
  init(data: T) {
    self.data = data
  }
}
