//
//  MockStoreKit.swift
//  Pods
//
//  Created by David Kraus on 06/01/2017.
//
//

import Foundation

public protocol MockStoreKitDelegate: class {

    func productForIdentifier(ident: String) -> SKProduct?
    
}

