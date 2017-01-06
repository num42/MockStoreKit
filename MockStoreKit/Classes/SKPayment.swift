
//
//  SKPayment.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

//@available(iOS 3.0, *)
public class SKPayment: NSObject {


    init(productIdentifier: String, quantity: Int = 1, requestData: Data? = nil) {
        self.productIdentifier = productIdentifier
        self.quantity = quantity
        self.requestData = requestData
    }

//    @available(iOS 3.0, *)
    public convenience init(product: SKProduct) {
        self.init(productIdentifier: product.productIdentifier)
    }


    // Identifier agreed upon with the store.  Required.
//    @available(iOS 3.0, *)
    public let productIdentifier: String


    // Payment request data agreed upon with the store.  Optional.
//    @available(iOS 3.0, *)
    public let requestData: Data?


    // default: 1.  Must be at least 1.
//    @available(iOS 3.0, *)
    public let quantity: Int


    // Application-specific user identifier.  Optional.
//    @available(iOS 7.0, *)
//    open var applicationUsername: String? { get }


    // Force an "ask to buy" flow for this payment, in the sandbox
//    @available(iOS 8.3, *)
//    open var simulatesAskToBuyInSandbox: Bool { get }



}

