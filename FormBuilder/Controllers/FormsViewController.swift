//
//  FormsViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

class FormsViewController: ProviderController {

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
  }
}

