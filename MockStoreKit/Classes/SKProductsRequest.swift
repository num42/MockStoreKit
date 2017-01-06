
//
//  SKProductsRequest.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

public protocol SKProductsRequestDelegate : SKRequestDelegate {


    // Sent immediately before -requestDidFinish:
//    @available(iOS 3.0, *)
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse)
}

// request information about products for your application
//@available(iOS 3.0, *)
open class SKProductsRequest : SKRequest {

    let ids: Set<String>
    var cancelled: Bool = false

    weak var mockDelegate: MockStoreKitDelegate!


    // Set of string product identifiers
//    @available(iOS 3.0, *)
    public init(productIdentifiers: Set<String>) {
        self.ids = productIdentifiers
    }


//    @available(iOS 3.0, *)
    open var delegate: SKProductsRequestDelegate? {
        set {
            self._delegate = newValue
        }

        get {
            return self._delegate as? SKProductsRequestDelegate
        }
    }


    open override func cancel() {
        cancelled = true
    }



    open override func start() {

        var prods = [SKProduct]()
        var badIDs = [String]()

        for ident in ids {
            let p = mockDelegate.productForIdentifier(ident: ident)
            if p != nil {
                prods.append(p!)
            } else {
                badIDs.append(ident)
            }
        }

        let response = SKProductsResponse.init(products: prods, invalidProductIdentifiers: badIDs)


//        self.perform(#selector(produceResponse(response:)), with: response, afterDelay: 2)
        produceResponse(response: response)


    }

    @objc fileprivate func produceResponse(response: SKProductsResponse) {
        self.delegate?.productsRequest(self, didReceive: response)
        if !cancelled {
            self.delegate?.requestDidFinish?(self)
        }
    }

}

//@available(iOS 3.0, *)
public class SKProductsResponse: NSObject {

    init(products: [SKProduct], invalidProductIdentifiers: [String]) {
        self.products = products
        self.invalidProductIdentifiers = invalidProductIdentifiers
    }
    


    // Array of SKProduct instances.
//    @available(iOS 3.0, *)
    public let products: [SKProduct]

    // Array of invalid product identifiers.
//    @available(iOS 3.0, *)
    public let invalidProductIdentifiers: [String]
}
