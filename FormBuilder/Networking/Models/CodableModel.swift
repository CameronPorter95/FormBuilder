//
//  CodableModel.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct CodableModel: Codable {
  var name: String?
  var id: Int?
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case id = "id"
  }
}
