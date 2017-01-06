# MockStoreKit

[![CI Status](http://img.shields.io/travis/num42/MockStoreKit.svg?style=flat)](https://travis-ci.org/num42/MockStoreKit)
[![Version](https://img.shields.io/cocoapods/v/MockStoreKit.svg?style=flat)](http://cocoapods.org/pods/MockStoreKit)
[![License](https://img.shields.io/cocoapods/l/MockStoreKit.svg?style=flat)](http://cocoapods.org/pods/MockStoreKit)
[![Platform](https://img.shields.io/cocoapods/p/MockStoreKit.svg?style=flat)](http://cocoapods.org/pods/MockStoreKit)



Overview
-------
A StoreKit implementation to make IAP debugging with the iOS simulator easier.

This is a swift port of SimStoreKit [simstorekit].

## Usage

To use MockStoreKit change the import when using the iOS simulator:
```swift
#if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
import MockStoreKit
#else
import StoreKit
#endif
```

To provide mocked products use the mockDelegate inside the SKPaymentQueue and SKProductsRequest class.


## Warnings & TODOs
This is by no means ready to do serious IAP testing.

TODO:
* The whole library needs to be reviewed completely.
* Unit tests
* Test all types of products (renewable, ...)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MockStoreKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MockStoreKit"
```

## Requirements


## Author

David Kraus, kraus.david.dev@gmail.com

License
-------

    Copyright 2016 Number42

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


[simstorekit]: https://github.com/millenomi/simstorekit
