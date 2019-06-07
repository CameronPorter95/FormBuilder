//
//  FormsViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import SwiftyJSON

class FormsViewController: ProviderController, JSONDelegate {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var formIDTextField: UITextField!
  
  var jsonSchema: JSONSchema<SchemaRoot>? {
    didSet {
      guard let schema = jsonSchema,
      let provider = backendProvider else { return }
      for view in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
      }
      for view in FormBuilder(backendProvider: provider).generateForm(from: schema)?.arrangedSubviews ?? [] {
        stackView.addArrangedSubview(view)
      }
      print("FormRefreshed")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider()
    backendProvider?.jsonProvider.delegates.append(self)
    getJSON()
  }
  
  func getJSON() {
    guard let provider = backendProvider else { return }
    let id = formIDTextField.text != nil ? Int(formIDTextField.text!) != nil ? Int(formIDTextField.text!) : 1 : 1
    _ = provider.jsonProvider.getJSON(for: id!)
  }
  
  func getJSONDidSucceed(json: JSON) {
    self.jsonSchema = JSONSchema(json: json)
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    getJSON()
  }
}
