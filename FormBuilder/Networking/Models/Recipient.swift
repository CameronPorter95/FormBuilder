//
//  Recipient.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 2/09/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Recipient: JsonStructure {
  var json: JSON?
  
  init(_ json: JSON) {
    self.json = json
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.singleValueContainer()
    let json = try values.decode(JSON.self)
    self.json = json
  }
  
  var name: String? {
    get {
      return json?["name"].stringValue
    } set {
      guard let newValue = newValue else { return }
      set("name", newValue)
    }
  }
}
