//
//  FormBuilder.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

class FormBuilder {
  func generateForm<T: SchemaBranch>(from schema: JSONSchema<T>) -> UIStackView? {
    let form = UIStackView()
    guard let properties = schema.root.properties else { return form }
    
    for property in properties.values where property is SchemaProperty {
      form.addArrangedSubview(createField(property as! SchemaProperty))
    }
    return form
  }
  
  private func createField(_ property: SchemaProperty) -> UIView {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    let f = AnimatedField()
    f.translatesAutoresizingMaskIntoConstraints = false
    f.showBottomLine = true
    f.setupStyle()
    f.labelText = property.title?.uppercased()
    
//    switch property.self {
//    case let remote as SchemaRemoteProperty:
//      let p = UIPickerView()
//      f.textField.inputView = p
//      break
//    default:
//      <#code#>
//    }
    v.addSubview(f)
    
    f.heightAnchor.constraint(equalToConstant: 60).isActive = true
    f.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
    
    let m = v.layoutMarginsGuide
    f.leadingAnchor.constraint(equalTo: m.leadingAnchor,
                               constant: 20).isActive = true
    f.trailingAnchor.constraint(equalTo: m.trailingAnchor,
                                constant: -20).isActive = true
    
    v.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    return v
  }
}
