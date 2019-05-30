//
//  NibType.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import UIKit

/// A mixin for .xib-based views that provides `nibInit` implementation
protocol NibType {
    /// A view to be loaded later from .xib file.
    var view: UIView! { get }
}

extension NibType where Self: UIView {
    /// Loads a subview from a .xib file that has the same name as the view class.
    /// This new subview has its `frame` set to the same value as `bounds` of
    /// the parent view.
    func nibInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                 owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
    }
}

extension NibType where Self: UIButton {
    /// Loads a subview from a .xib file that has the same name as the view class.
    /// This new subview has its `frame` set to the same value as `bounds` of
    /// the parent view.
    func nibInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                 owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.isUserInteractionEnabled = false
    }
}
