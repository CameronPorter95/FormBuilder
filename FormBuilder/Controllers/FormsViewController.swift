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
  @IBOutlet weak var formTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var sendTextField: UITextField!
  @IBOutlet weak var payoutTextField: UITextField!
  
  var request = FormRequest(
    form: "recipient",
    recipientType: "bank_account",
    send: "NZD",
    payout: "PHP")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    generateForm(for: request)
    backendProvider?.recipientProvider.getRecipients()
  }
  
  @IBAction func refreshFormPressed(_ sender: Any) {
    request.form = formTextField.text == "" ? "recipient" : formTextField.text ?? "recipient"
    request.recipientType = typeTextField.text == "" ? "bank_account" : typeTextField.text ?? "bank_account"
    request.send = sendTextField.text == "" ? "NZD" : sendTextField.text ?? "NZD"
    request.payout = payoutTextField.text == "" ? "PHP" : payoutTextField.text ?? "PHP"
    
    generateForm(for: request)
  }
}
