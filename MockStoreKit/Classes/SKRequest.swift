
//
//  SKRequest.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

// Base class used to fetch data from the store.  Should not be used directly.
//@available(iOS 3.0, *)
open class SKRequest: NSObject {


//    @available(iOS 3.0, *)
    open var _delegate: SKRequestDelegate?


    // Cancel the request if it has started.
//    @available(iOS 3.0, *)
    open func cancel() {}


    // Start the request if it has not already been started.
//    @available(iOS 3.0, *)
    open func start() {}
}

@objc public protocol SKRequestDelegate : NSObjectProtocol {


//    @available(iOS 3.0, *)
    @objc optional func requestDidFinish(_ request: SKRequest)

//    @available(iOS 3.0, *)
    @objc optional func request(_ request: SKRequest, didFailWithError error: Error)
}
