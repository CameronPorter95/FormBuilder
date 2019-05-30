//
//  ProviderController.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya

/// Base controller class that facilitates dependecy injection of
/// `BackendProvider` instances through segues
class ProviderController: UIViewController, ProviderMixin {
  var backendProvider: BackendProvider?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    passProvider(segue.destination)
  }
}

protocol ProviderMixin: class {
  var backendProvider: BackendProvider? { get set }
}

extension ProviderMixin {
  func passProvider(_ destination: UIViewController) {
    var destination = destination
    
    if let navigation = destination as? UINavigationController,
      let top = navigation.topViewController {
      destination = top
    } else if let controller = destination as? UITabBarController,
      let tabs = controller.viewControllers {
      destination = controller
      for t in tabs {
        passProvider(t)
      }
      
      return
    }
    
    guard let next = destination as? ProviderMixin,
      let provider = backendProvider else {
        return
    }
    
    next.backendProvider = provider
  }
}
