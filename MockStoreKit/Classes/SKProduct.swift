
//
//  SKProduct.h
//  StoreKit
//
//  Copyright 2009 Apple, Inc. All rights reserved.
//

@objc public enum SimulatedProductType: Int {
    case nonConsumable = 0,
    consumable
}

//@available(iOS 3.0, *)
public class SKProduct: NSObject {

    init(localizedDescription: String, localizedTitle: String, price: NSDecimalNumber, priceLocale: Locale, productIdentifier: String, simulatedProductType: SimulatedProductType) {
        self.localizedDescription = localizedDescription
        self.localizedTitle = localizedTitle
        self.price = price
        self.priceLocale = priceLocale
        self.productIdentifier = productIdentifier
        self.simulatedProductType = simulatedProductType
    }


//    @available(iOS 3.0, *)
    public let localizedDescription: String


//    @available(iOS 3.0, *)
    public let localizedTitle: String


//    @available(iOS 3.0, *)
    public let price: NSDecimalNumber


//    @available(iOS 3.0, *)
    public let priceLocale: Locale


//    @available(iOS 3.0, *)
    public let productIdentifier: String


//    // YES if this product has content downloadable using SKDownload
//    @available(iOS 6.0, *)
//    open var isDownloadable: Bool { get }
//
//
//    // Sizes in bytes (NSNumber [long long]) of the downloads available for this product
//    @available(iOS 6.0, *)
//    open var downloadContentLengths: [NSNumber] { get }
//
//
//    // Version of the downloadable content
//    @available(iOS 6.0, *)
//    open var downloadContentVersion: String { get }


    // META DATA

    // needed meta data
    public let simulatedProductType: SimulatedProductType



}
