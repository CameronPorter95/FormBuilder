//
//  FormsViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

class FormsViewController: ProviderController {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var formIDTextField: UITextField!
  
  private var generatedTextFields = [AnimatedField]()
  
  var jsonSchema: JSONSchema<SchemaRoot>? {
    didSet {
      guard let schema = jsonSchema else { return }
      for view in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
      }
      for view in FormBuilder().generateForm(from: schema)?.arrangedSubviews ?? [] {
        stackView.addArrangedSubview(view)
      }
      print("FormRefreshed")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider()
    getJSON()
  }
  
  func getJSON(completion: ((JSON) -> ())? = nil) {
    let id = formIDTextField.text != nil ? Int(formIDTextField.text!) != nil ? Int(formIDTextField.text!) : 1 : 1
    let jsonCollection = JSONCollection {
      (self.backendProvider?.future(.getForms(id: id!)))! //TODO Fix force unwrap
    }
    jsonCollection.refresh()? //TODO move this to a jsonprovider class with delegate calls to onsuceed/onbegin etc
    .onSuccess { json in
      self.jsonSchema = JSONSchema(json: jsonCollection.json)
      completion?(jsonCollection.json)
    }
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    getJSON { json in
      self.generatedTextFields.removeAll()
      self.jsonSchema = JSONSchema(json: json)
    }
  }
}

