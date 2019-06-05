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
  
  private var generatedTextFields = [AnimatedField]()
  
  var jsonSchema: JSONSchema<SchemaRoot>? {
    didSet {
      guard let properties = jsonSchema?.root.properties else { return }
      for view in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
      }
      
      for property in properties.values where property is SchemaProperty {
        setupField(property as! SchemaProperty)
      }
      print("FormRefreshed")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider()
    getJSON { json in
      self.jsonSchema = JSONSchema(json: json)
    }
  }
  
  func getJSON(completion: @escaping (JSON) -> ()) {
  backendProvider?.future(.getFormsTwo())
    .onSuccess { response in
      do {
        let result = try JSONSerialization.jsonObject(with: response.data, options: []) //Wrap this in a backendProvider function that throws an error
        guard let json = result as? JSON,
        let data = json["data"] as? JSON else {
            return
        }
        completion(data)
      } catch {
        print("failed to map to json dictionary")
      }
    }
    .onFailure { error in
      print(error.localizedDescription)
    }
  }
  
  func setupField(_ property: SchemaProperty) {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    let f = AnimatedField()
    f.translatesAutoresizingMaskIntoConstraints = false
    f.showBottomLine = true
    f.setupStyle()
    f.labelText = property.title?.uppercased()
    v.addSubview(f)
    
    f.heightAnchor.constraint(equalToConstant: 60).isActive = true
    f.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
    
    let m = v.layoutMarginsGuide
    f.leadingAnchor.constraint(equalTo: m.leadingAnchor,
                               constant: 20).isActive = true
    f.trailingAnchor.constraint(equalTo: m.trailingAnchor,
                                constant: -20).isActive = true
    
    stackView.addArrangedSubview(v)
    
    v.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    generatedTextFields.append(f)
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    getJSON { json in
      self.generatedTextFields.removeAll()
      self.jsonSchema = JSONSchema(json: json)
    }
  }
}

