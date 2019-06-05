//
//  Styles.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 5/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

extension UIFont {
  static func animatedFieldLabel(size: CGFloat = 14) -> UIFont {
    return appFont(weight: "Medium", size: size)
  }
  
  static func appFont(weight w: String = "Book",
                      size s: CGFloat = 16) -> UIFont {
    return UIFont(name: "Avenir-\(w)", size: s)!
  }
}

extension AnimatedField {
  func setupStyle(size: CGFloat = 14) {
    label.font = .animatedFieldLabel(size: size)
    labelColor = .lightGray
  }
}
