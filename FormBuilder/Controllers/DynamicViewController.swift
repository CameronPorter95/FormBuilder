//
//  DynamicViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 10/06/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import Moya

class DynamicViewController: ProviderController, SchemaDelegate {
  @IBOutlet weak var stackView: UIStackView!
  
  var dataSources = [UIPickerViewDataSource & UIPickerViewDelegate]() //Needed to prevent datasources from being deallocated
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider.newWithAuthLoggerActivity()
    backendProvider?.formProvider.delegates.append(self)
  }
  
  func generateForm(for request: FormRequest) {
    guard let provider = backendProvider else { return }
    _ = provider.formProvider.getSchema(for: request)
  }
  
  func getSchemaDidSucceed(schema: JSONSchema<SchemaRoot>) {
    for view in stackView.arrangedSubviews {
      stackView.removeArrangedSubview(view)
      view.removeFromSuperview()
    }
    for view in FormBuilder(for: self).generateForm(from: schema)?.arrangedSubviews ?? [] {
      stackView.addArrangedSubview(view)
    }
    print("FormRefreshed")
  }
}
