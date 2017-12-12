//
//  SKPaymentTransaction.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

import Foundation

// @available(iOS 3.0, *)
public enum SKPaymentTransactionState: Int {

  case purchasing // Transaction is being added to the server queue.

  case purchased // Transaction is in queue, user has been charged.  Client should complete the transaction.

  case failed // Transaction was cancelled or failed before being added to the server queue.

  case restored // Transaction was restored from user's purchase history.  Client should complete the transaction.

  // available since ios 8 but wee need it in order to be compatible
  //    @available(iOS 8.0, *)
  case deferred // The transaction is in the queue, but its final status is pending external action.
}

// @available(iOS 3.0, *)
open class SKPaymentTransaction: NSObject {

  init(error: Error? = nil, original: SKPaymentTransaction? = nil, payment: SKPayment, transactionDate: Date?, transactionIdentifier: String?, transactionState: SKPaymentTransactionState) {
    self.error = error
    self.original = original
    self.payment = payment
    self.transactionDate = transactionDate
    self.transactionIdentifier = transactionIdentifier
    self.transactionState = transactionState
  }

  // Only set if state is SKPaymentTransactionFailed
  //    @available(iOS 3.0, *)
  open var error: Error?

  // Only valid if state is SKPaymentTransactionStateRestored.
  //    @available(iOS 3.0, *)
  open var original: SKPaymentTransaction?

  //    @available(iOS 3.0, *)
  open var payment: SKPayment

  // Available downloads (SKDownload) for this transaction
  //    @available(iOS 6.0, *)
  //    open var downloads: [SKDownload] { get }

  // The date when the transaction was added to the server queue.  Only valid if state is SKPaymentTransactionStatePurchased or SKPaymentTransactionStateRestored.
  //    @available(iOS 3.0, *)
  open var transactionDate: Date?

  // The unique server-provided identifier.  Only valid if state is SKPaymentTransactionStatePurchased or SKPaymentTransactionStateRestored.
  //    @available(iOS 3.0, *)
  open var transactionIdentifier: String?

  //    @available(iOS 3.0, *)
  open var transactionState: SKPaymentTransactionState
}
