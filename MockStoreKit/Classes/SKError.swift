//
//  SKError.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

import Foundation

@available(iOS 3.0, *)
public let SKErrorDomain: String = "SKErrorDomain"

// error codes for the SKErrorDomain
public struct SKError {

  public init(_nsError: NSError) {
    // TODO:
  }

  public static var _nsErrorDomain: String { return SKErrorDomain }

  public enum Code: Int {

    public typealias _ErrorType = SKError

    case unknown

    case clientInvalid // client is not allowed to issue the request, etc.

    case paymentCancelled // user cancelled the request, etc.

    case paymentInvalid // purchase identifier was invalid, etc.

    case paymentNotAllowed // this device is not allowed to make the payment

    case storeProductNotAvailable // Product is not available in the current storefront

    //        @available(iOS 9.3, *)
    //        case cloudServicePermissionDenied // user has not allowed access to cloud service information
    //
    //        @available(iOS 9.3, *)
    //        case cloudServiceNetworkConnectionFailed // the device could not connect to the nework
  }

  public static var unknown: SKError.Code { return SKError.Code.unknown }

  public static var clientInvalid: SKError.Code { return SKError.Code.clientInvalid }

  public static var paymentCancelled: SKError.Code { return SKError.Code.paymentCancelled }

  public static var paymentInvalid: SKError.Code { return SKError.Code.paymentInvalid }

  public static var paymentNotAllowed: SKError.Code { return SKError.Code.paymentNotAllowed }

  public static var storeProductNotAvailable: SKError.Code { return SKError.Code.storeProductNotAvailable }

  //    @available(iOS 9.3, *)
  //    public static var cloudServicePermissionDenied: SKError.Code { get }
  //
  //    @available(iOS 9.3, *)
  //    public static var cloudServiceNetworkConnectionFailed: SKError.Code { get }
}
