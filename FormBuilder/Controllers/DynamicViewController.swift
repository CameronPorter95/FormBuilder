//
//  DynamicViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 10/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

class DynamicViewController: ProviderController, JSONDelegate {
  @IBOutlet weak var stackView: UIStackView!
  
  var dataSources = [UIPickerViewDataSource & UIPickerViewDelegate]() //Needed to prevent datasources from being deallocated
  var jsonSchema: JSONSchema<SchemaRoot>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider.newWithAuthLoggerActivity()
    backendProvider?.jsonProvider.delegates.append(self)
  }
  
  func generateForm(for request: FormRequest) {
    guard let provider = backendProvider else { return }
    _ = provider.jsonProvider.getJSON(for: request)
  }
  
  func getJSONDidSucceed(json: JSON) {
    self.jsonSchema = JSONSchema(json: json)
    for view in stackView.arrangedSubviews {
      stackView.removeArrangedSubview(view)
      view.removeFromSuperview()
    }
    for view in FormBuilder(for: self).generateForm(from: self.jsonSchema!)?.arrangedSubviews ?? [] {
      stackView.addArrangedSubview(view)
    }
    print("FormRefreshed")
  }
}
