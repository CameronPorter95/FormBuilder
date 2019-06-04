//
//  PropertyIterable.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 4/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

protocol PropertyIterable
{
  var allProperties: [String] { get }
}

extension PropertyIterable
{
  var allProperties: [String] {
    return Mirror(reflecting: self).children.compactMap({
      $0.label
    })
  }
}
