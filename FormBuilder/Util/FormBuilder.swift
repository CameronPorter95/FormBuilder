//
//  FormBuilder.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import SwiftPath
import SwiftyJSON

class FormBuilder {
  let viewController: DynamicViewController!
  
  init(for viewController: DynamicViewController) {
    self.viewController = viewController
  }
  
  func generateForm<T: SchemaBranch>(from schema: JSONSchema<T>) -> UIStackView? {
    let form = UIStackView()
    guard let properties = schema.root.properties else { return form }
    
    for property in properties.values where property is SchemaProperty {
      guard let field = createField(property as! SchemaProperty) else { return nil }
      form.addArrangedSubview(field)
    }
    return form
  }
  
  private func createField(_ property: SchemaProperty) -> UIView? {
    guard let provider = viewController.backendProvider else { return nil }
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    let f = AnimatedField()
    f.translatesAutoresizingMaskIntoConstraints = false
    f.showBottomLine = true
    f.setupStyle()
    f.labelText = property.title?.uppercased()
    
    switch property.self {
    case let remote as SchemaRemoteProperty:
      guard let url = remote.url,
      let namePath = remote.namePath else {
        break
      }
      let p = UIPickerView()
      f.textField.inputView = p
      
      let c = JSONCollection {
        provider.future(.getCustom(path: url))
      }
      c.refresh()
      .onSuccess { (json: JSON) in
        if let path = SwiftPath(namePath),
        let names = try? path.evaluate(with: c.json.dictionaryObject as JsonValue) {
          let ds = PickerDataSource<[String]>(collection: [names as! String]) { row in
            guard let row = row else {
              f.textFieldText = nil
              return
            }
            f.textFieldText = row
          }
          
          self.viewController.dataSources.append(ds)
          p.dataSource = ds
          p.delegate = ds
        }
      }

      break
    default:
      break
    }
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
