//
//  AnimatedField.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit
import NextResponderTextField

final class AnimatedField: UIView, NibType {
  @IBOutlet var view: UIView!
  @IBOutlet weak var textField: NextResponderTextField!
  @IBOutlet weak var label: UILabel!
  
  let line = UIView()
  
  private var textFieldEmpty: Bool {
    return textField.text == nil || textField.text!.isEmpty
  }
  
  // preferred way of changing text field text
  // to avoid label overlapping with the label
  var textFieldText: String? {
    get {
      return textField.text
    }
    
    set {
      textField.text = newValue
      //TODO animate label if textfield is empty
    }
  }
  
  @IBInspectable var labelText: String? {
    get {
      return label.text
    }
    set {
      label.text = newValue
    }
  }
  
  @IBInspectable var labelColor: UIColor = .black {
    didSet {
      label.textColor = labelColor
    }
  }
  
  @IBInspectable var showBottomLine: Bool = false {
    didSet {
      line.translatesAutoresizingMaskIntoConstraints = false
      line.backgroundColor = UIColor(white: 0.89, alpha: 1)
      view.addSubview(line)
      
      line.heightAnchor.constraint(equalToConstant: 2).isActive = true
      line.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      line.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      line.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    sharedInit()
  }
  
  private func sharedInit() {
    nibInit()
  }
}

extension AnimatedField: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    label.isHidden = true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    label.isHidden = false
  }
}
