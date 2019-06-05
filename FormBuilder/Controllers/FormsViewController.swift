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
  
  var jsonSchema: JSONSchema<SchemaRoot>? {
    didSet {
      print("FormRefreshed")
      //stackView.addArrangedSubview()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    backendProvider = BackendProvider()
    
    backendProvider!.futureObject(.getCodableModel())
    .onSuccess { (codable: CodableModel) in
      guard let name = codable.name else { return }
      print("Got a codable example with name \(name)")
    }
    .onFailure { error in
      print(error.response?.description ?? "Couldn't fetch a codable!")
    }
    
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
  
  func setupField(schemaBranch) {
    let f = AnimatedField()
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    getJSON { json in
      self.jsonSchema = JSONSchema(json: json)
    }
  }
}

