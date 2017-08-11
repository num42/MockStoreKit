//
//  ViewController.swift
//  TraitAwareVC-Demo
//
//  Created by Wolfgang Lutz on 12.02.17.
//  Copyright © 2017 Wolfgang Lutz. All rights reserved.
//

import UIKit
import MockStoreKit

class ViewController: UIViewController {
  
  let label = UILabel()
  let greenView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.setupConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    updateLabel()
    activateConstraintsBasedOnTraitCollection()
  }

  func setupViews() {
    self.greenView.backgroundColor = .green
    self.view.addSubview(greenView)
    
    label.text = "initial"
    label.numberOfLines = 2
    label.textColor = UIColor.black
    self.greenView.addSubview(label)
  }
  
  func setupConstraints() {
    self.view.translatesAutoresizingMaskIntoConstraints = false
    self.label.translatesAutoresizingMaskIntoConstraints = false
    self.greenView.translatesAutoresizingMaskIntoConstraints = false
    
    // Center Label in Green View
    self.insertConstraint(label.centerXAnchor.constraint(equalTo: self.greenView.centerXAnchor))
    self.insertConstraint(label.centerYAnchor.constraint(equalTo: self.greenView.centerYAnchor))
  
    // Fixed Width of Green View
    self.insertConstraint(self.greenView.widthAnchor.constraint(equalToConstant: 100))
    self.insertConstraint(self.greenView.heightAnchor.constraint(equalToConstant: 100))
    
    // For Horizontally Regular, GreenView is in lower-leading corner
    self.insertConstraint(self.greenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), horizontally: .regular)
    self.insertConstraint(self.greenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor), horizontally: .regular)

    // For Horizontally Compact, GreenView is in upper-trailing corner
    self.insertConstraint(self.greenView.topAnchor.constraint(equalTo: self.view.topAnchor), horizontally: .compact)
    self.insertConstraint(self.greenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), horizontally: .compact)
  }
  
  internal func updateLabel() {
    self.label.text = "v: \(self.traitCollection.verticalSizeClass.name())\n" +
    "h: \(self.traitCollection.horizontalSizeClass.name())"
  }
}
