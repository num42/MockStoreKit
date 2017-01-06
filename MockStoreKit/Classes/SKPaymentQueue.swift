
//
//  SKPaymentQueue.h
//  StoreKit
//
//  Copyright 2009-2010 Apple, Inc. All rights reserved.
//

// SKPaymentQueue interacts with the server-side payment queue
//@available(iOS 3.0, *)
open class SKPaymentQueue : NSObject {

    fileprivate static let sharedInstance = SKPaymentQueue()

//    @available(iOS 3.0, *)
    open class func `default`() -> SKPaymentQueue {
        return sharedInstance
    }

    var observers: NSMutableSet

    var currentTransaction: SKPaymentTransaction?

    weak var mockDelegate: MockStoreKitDelegate!


    // Array of unfinished SKPaymentTransactions.  Only valid while the queue has observers.  Updated asynchronously.
    //    @available(iOS 3.0, *)
    open var transactions: [SKPaymentTransaction]

    override init() {

        self.observers = NSMutableSet()
        self.transactions = [SKPaymentTransaction]()

        if var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            dir.deleteLastPathComponent()
            let path = dir.appendingPathComponent("StoreKit")

            do {
                try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
                try "receipt".write(to: path.appendingPathComponent("receipt"), atomically: false, encoding: String.Encoding.utf8)
            }
            catch let error { print(error.localizedDescription) }
        }





    }


    // NO if this device is not able or allowed to make payments
//    @available(iOS 3.0, *)
    open class func canMakePayments() -> Bool {
        return true
    }


    // Asynchronous.  Add a payment to the server queue.  The payment is copied to add an SKPaymentTransaction to the transactions array.  The same payment can be added multiple times to create multiple transactions.
//    @available(iOS 3.0, *)
    @objc(addPayment:)
    open func add(_ payment: SKPayment) {

        assert(SKPaymentQueue.canMakePayments(),"Payments must be available to add payments onto the queue")

        let transaction = SKPaymentTransaction(error: nil, original: nil, payment: payment, transactionDate: Date(), transactionIdentifier: nil, transactionState: .purchasing)

        transactions.append(transaction)

        if observers.count > 0 {
            self.processNextTransaction()
        }

    }

    @objc fileprivate func processNextTransaction() {
        if currentTransaction != nil {
            return
        }

        if transactions.count == 0 {
            return
        }

        self.currentTransaction = transactions[0]

        self.currentTransaction!.transactionState = .purchasing
        for observer in observers {
            (observer as! SKPaymentTransactionObserver).paymentQueue(self, updatedTransactions: [self.currentTransaction!])
        }

        self.currentTransaction!.transactionIdentifier = "\(arc4random())"


        self.succeed()

        // TODO: self.fail()

    }

    fileprivate func succeed() {

        let product = mockDelegate.productForIdentifier(ident: self.currentTransaction!.payment.productIdentifier)


        let plist = [  "ProductID" : product!.productIdentifier,
                        "Quantity" : self.currentTransaction!.payment.quantity,
                        "TransactionID" :self.currentTransaction!.transactionIdentifier!,
                        "Date" : self.currentTransaction!.transactionDate!.timeIntervalSince1970,
                        "ProductType" : product!.simulatedProductType.rawValue] as [String : Any]

        do {

            self.currentTransaction!.transactionState = .purchased;

            var storedTransactions = UserDefaults.standard.array(forKey: "SKTransactions")

            if storedTransactions == nil {
                storedTransactions = []
            }


            var shouldAdd = true

            if (product!.simulatedProductType == .nonConsumable) {
                for receipt in storedTransactions as! [Dictionary<String, Any>] {

                    if receipt["ProductID"] as! String == product!.productIdentifier {
                        shouldAdd = false
                        break
                    }
                }
            }
            
            if shouldAdd {
                storedTransactions!.append(plist)
                UserDefaults.standard.setValue(storedTransactions!, forKey: "SKTransactions")
            }

            signalFinished()
        } catch let error {
            // TODO: implement fail
            print(error.localizedDescription)
        }



    }

    func signalFinished() {
        for observer in observers {
            (observer as! SKPaymentTransactionObserver).paymentQueue(self, updatedTransactions: [self.currentTransaction!])
        }
    }


    // Asynchronous.  Will add completed transactions for the current user back to the queue to be re-completed.  User will be asked to authenticate.  Observers will receive 0 or more -paymentQueue:updatedTransactions:, followed by eithvar-paymentQueueRestoreCompletedTransactionsFinished: on success or -paymentQueue:restoreCompletedTransactionsFailedWithError: on failure.  In the case of partial success, some transactions may still be delivered.
//    @available(iOS 3.0, *)
    open func restoreCompletedTransactions() {


        var transactions = [SKPaymentTransaction]()

        var storedTransactions = UserDefaults.standard.array(forKey: "SKTransactions")

        if storedTransactions == nil {
            return
        }

        for transaction in storedTransactions as! [Dictionary<String, Any>] {



            let kind = transaction["ProductType"] as! Int
            if (kind != SimulatedProductType.nonConsumable.rawValue) {
                continue
            }




            let payment = SKPayment(productIdentifier:transaction["ProductID"] as! String, quantity: transaction["Quantity"] as! Int)
            let original = SKPaymentTransaction(payment: payment, transactionDate: Date(timeIntervalSince1970:transaction["Date"] as! TimeInterval), transactionIdentifier: transaction["TransactionID"] as! String, transactionState: .restored)

            let newTrans = SKPaymentTransaction(original: original, payment: payment, transactionDate: Date(), transactionIdentifier: "\(arc4random())", transactionState: .restored)

            transactions.append(newTrans)
        }

        if transactions.count > 0 {
            for observer in observers {
                (observer as! SKPaymentTransactionObserver).paymentQueue(self, updatedTransactions: transactions)
            }
        }

        for observer in observers {
            (observer as! SKPaymentTransactionObserver).paymentQueueRestoreCompletedTransactionsFinished?(self)
        }
    }

//    @available(iOS 7.0, *)
//    open func restoreCompletedTransactions(withApplicationUsername username: String?)


    // Asynchronous.  Remove a finished (i.e. failed or completed) transaction from the queue.  Attempting to finish a purchasing transaction will throw an exception.
//    @available(iOS 3.0, *)
    open func finishTransaction(_ transaction: SKPaymentTransaction) {
        if self.transactions.count > 0 && self.currentTransaction! == self.transactions[0] {
            self.transactions.remove(at: 0)
        } else {
            return
        }

        for observer in observers {
            (observer as! SKPaymentTransactionObserver).paymentQueue?(self, removedTransactions: [self.currentTransaction!])
        }


        self.currentTransaction = nil;

        if observers.count > 0 {
            self.perform(#selector(processNextTransaction), with: nil, afterDelay: 2)
        }

    }


//    // Asynchronous.  Start the given downloads (SKDownload).
//    @available(iOS 6.0, *)
//    open func start(_ downloads: [SKDownload])
//
//
//    // Asynchronous.  Pause/resume downloads (SKDownload).
//    @available(iOS 6.0, *)
//    open func pause(_ downloads: [SKDownload])
//
//    @available(iOS 6.0, *)
//    open func resume(_ downloads: [SKDownload])
//
//
//    // Asynchronous.  Cancel downloads (SKDownload)
//    @available(iOS 6.0, *)
//    open func cancel(_ downloads: [SKDownload])


    // Observers are not retained.  The transactions array will only be synchronized with the server while the queue has observers.  This may require that the user authenticate.
//    @available(iOS 3.0, *)
    @objc(addTransactionObserver:)
    open func add(_ observer: SKPaymentTransactionObserver) {
        observers.add(observer)
        self.processNextTransaction()
    }

//    @available(iOS 3.0, *)
    open func remove(_ observer: SKPaymentTransactionObserver) {
        observers.remove(observer)
        // TODO: stop
    }


}

@objc public protocol SKPaymentTransactionObserver : NSObjectProtocol {


    // Sent when the transaction array has changed (additions or state changes).  Client should check state of transactions and finish as appropriate.
//    @available(iOS 3.0, *)
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])


    // Sent when transactions are removed from the queue (via finishTransaction:).
//    @available(iOS 3.0, *)
    @objc optional func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction])


    // Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
//    @available(iOS 3.0, *)
    @objc optional func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error)


    // Sent when all transactions from the user's purchase history have successfully been added back to the queue.
//    @available(iOS 3.0, *)
    @objc optional func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue)


    // Sent when the download state has changed.
//    @available(iOS 6.0, *)
//    optional public func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload])
}
