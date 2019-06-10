//
//  FormsViewController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import SwiftyJSON

class FormsViewController: DynamicViewController {
  @IBOutlet weak var formIDTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    generateForm(for: 1)
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    let id = formIDTextField.text != nil ? Int(formIDTextField.text!) != nil ? Int(formIDTextField.text!) : 1 : 1
    generateForm(for: id!)
  }
}
