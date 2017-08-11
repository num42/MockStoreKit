//
//  UIUserInterfaceSizeClass.swift
//  TraitAwareVC-Demo
//
//  Created by Wolfgang Lutz on 12.02.17.
//  Copyright © 2017 Wolfgang Lutz. All rights reserved.
//

import UIKit

extension UIUserInterfaceSizeClass {
  func name() -> String{
    if self == .compact {
      return "compact"
    } else if self == .regular {
      return "regular"
    } else {
      return "undefined"
    }
  }
}
