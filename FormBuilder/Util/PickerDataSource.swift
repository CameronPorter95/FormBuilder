//
//  PickerDataSource.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 6/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

final class PickerDataSource<T>: NSObject, UIPickerViewDataSource,
  UIPickerViewDelegate where T: Collection, T.Index == Int,
T.Iterator.Element: CustomStringConvertible {
  var collection: T
  let onSelection: (T.Iterator.Element?) -> ()
  
  init(collection: T, onSelection: @escaping (T.Iterator.Element?) -> ()) {
    self.collection = collection
    self.onSelection = onSelection
    
    super.init()
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return collection.count + 1
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return row == 0 ? "" : collection[row - 1].description
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                  inComponent component: Int) {
    row == 0 ? onSelection(nil) : onSelection(collection[row - 1])
  }
}
