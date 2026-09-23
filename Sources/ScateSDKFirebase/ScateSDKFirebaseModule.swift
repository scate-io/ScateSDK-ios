//
//  ScateSDKFirebaseModule.swift
//  ScateSDKFirebase
//
//  Shipped as source next to the ScateSDK binary (CocoaPods pod / SPM product `ScateSDKFirebase`) and compiled with
//  the app's own Firebase. Not part of the ScateSDK target.
//

import FirebaseAnalytics
import ScateSDK
import StoreKit

/// Logs the purchases ScateSDK notices to Firebase with `Analytics.logTransaction`, Firebase's API for StoreKit 2.
/// Linking this module is all an app does: ScateSDK finds this class by name on Init.
@objc(ScateSDKFirebaseModule)
public final class ScateSDKFirebaseModule: NSObject, ScateSDKModule {
    public static func register() {
        guard #available(iOS 15.0, *) else { return }
        FirebaseTransactionLogging.logTransaction = { Analytics.logTransaction($0) }
    }
}
