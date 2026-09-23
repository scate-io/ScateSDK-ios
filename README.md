### Installation 

#### Swift Package Manager

In Xcode, go to **File → Add Package Dependencies…** and enter the package URL:

```
https://github.com/scate-io/ScateSDK-ios
```

Set the **Dependency Rule** to **Up to Next Major Version** from `7.0.20`, then add the **ScateSDK** library product to your app target.

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/scate-io/ScateSDK-ios", from: "7.0.20")
]
```

and depend on the `ScateSDK` product in your target.

The Adjust SDK (with the Google ODM plugin) is linked automatically as a dependency of the package — you don't need to add Adjust separately.

#### CocoaPods

Add following into your Podfile:

```ruby
    pod 'ScateSDK'
```

Example `Podfile`:

```ruby
    target 'YourApp' do
        use_frameworks!
        pod 'ScateSDK'
    end
```


Install the pod:

```bash
    pod install --repo-update
```


#### Usage

### Initialize the SDK

In your AppDelegate.swift file, import the ScateSDK module and initialize the SDK with your app ID in the `application(_:didFinishLaunchingWithOptions:)` method: or `init()` method of your main struct if you are using SwiftUI.

Register the remote config listener before initializing. It fires once per initialization and is not replayed, so a listener registered afterwards never sees it.

```swift

import SwiftUI
import ScateSDK

@main
struct ScateSDKTestApp: App {
    
    init(){
        
        NotificationCenter.default.addObserver(forName: ScateCoreSDK.RemoteConfigsReady, object: nil, queue: .main) { _ in
            // Remote configs are ready. Read them and leave the splash screen here.
        }

        ScateCoreSDK.Init(appID: "<your app ID>");
        ScateCoreSDK.InitAdjust(adjustToken: "<your adjust token>")

        ScateCoreSDK.GetAdjustId { adid in
            // ADID is non-empty here.
        }
    }

}

```

Do not read remote configs or show the first screen before the listener fires. `Init` returns immediately and never blocks on the network, so without this gate the app can render before any config has arrived. The listener always fires, `true` on a fresh fetch and `false` once retries are exhausted. A failing network is retried several times first, so if a slow network must not hold the splash, cap the wait at around five seconds and continue with cached or default values; a late answer still reaches the listener either way. The listener body is a callback, not a pause: `Init` and every line after it run straight away, and the body runs later, on its own, when the answer arrives. Put the config reads and the move off the splash screen inside the body.

By default, `InitAdjust` configures Adjust with a 120 second ATT consent wait interval and requests App Tracking Transparency authorization at init time. Add `NSUserTrackingUsageDescription` to the app Info.plist for the prompt to appear. Pass `noATT: true` to skip ScateSDK's ATT request path:

```swift
ScateCoreSDK.InitAdjust(adjustToken: "<your adjust token>", noATT: true)
```

When an ADID is resolved, ScateSDK stores it as the SDK ADID and sends `scate_adjust_id` once after ScateSDK is initialized. If your app already initializes Adjust, avoid calling `InitAdjust` a second time; keep your app-owned Adjust setup and call `ScateCoreSDK.GetAdjustId(...)` after Adjust is ready, or continue to use `ScateCoreSDK.SetAdid(adid:)`.

By default, when Firebase Analytics is linked and configured in the host app, ScateSDK sets Firebase `user_id` to the Scate user ID during initialization. If your app already manages Firebase `user_id`, disable this before initialization:

```swift
let configuration = ScateSDKConfiguration()
configuration.firebaseUserIdSyncEnabled = false
ScateCoreSDK.Init(appID: "<your app ID>", configuration: configuration)
```

### Purchases

ScateSDK notices purchases on its own; the app does not report them. Every time the app becomes active it sends
StoreKit's transaction history to Scate, which keeps the purchases it has not seen before (iOS 15 and later). When the
app links Firebase Analytics, new purchases are also logged to Firebase as `in_app_purchase`, once each: purchases
Firebase already logs by itself (StoreKit 1, or completed outside the purchase call) are left to Firebase. Nothing to
add or call; do not also log purchases to Firebase yourself, or each one is counted twice.

If your app sells consumables (credits, coins), set `SKIncludeConsumableInAppPurchaseHistory` to `YES` in your
`Info.plist`. Without it StoreKit drops a consumable from the history once it is finished, and ScateSDK never sees
that purchase (iOS 18 and later).

### Send Events

To send events, you can use the following code:

```swift
    
    ScateCoreSDK.Event(name: "button_clicked");

```

### Send Events with Parameters

Pass a dictionary as the optional `parameters` argument. These values are sent as event `parameters`.

```swift

    let parameters: [String: Any] = [
        "screen": "paywall",
        "position": 1,
        "isPrimary": true
    ]
    ScateCoreSDK.Event(name: "button_clicked", parameters: parameters as NSDictionary)

```

### Send Events with Additional Data

```swift

    ScateCoreSDK.Event(name: "button_click", customValue: "subscribe_btn");

```

### Send Events with a Custom Value and Parameters

Send a `customValue` and a `parameters` dictionary together in a single event.

```swift

    ScateCoreSDK.Event(
        name: "result",
        customValue: "grade_changed",
        parameters: ["grade": "PSA10"] as NSDictionary
    )

```

### Listen Remote Config Ready

```swift
NotificationCenter.default.addObserver(notificationHandler, 
                                       selector: #selector(notificationHandler.remoteConfigReady), 
                                       name: ScateCoreSDK.RemoteConfigsReady, 
                                       object: nil)
```

### Get Remote Config for Key

```swift
ScateSDK.GetRemoteConfig('key', 'defaultValue');
```

Typed reads fall back to the default when the value is not of that type.

```swift
let enabled = ScateCoreSDK.GetRemoteConfigBool(key: "new_camera", defaultValue: false)
let limit = ScateCoreSDK.GetRemoteConfigInt(key: "scan_limit", defaultValue: 10)
let ratio = ScateCoreSDK.GetRemoteConfigDouble(key: "crop_ratio", defaultValue: 1.5)
```

### Onboarding Event Functions

```swift
ScateCoreSDK.OnboardingStart();
ScateCoreSDK.OnboardingStep(step: "location_screen");
ScateCoreSDK.OnboardingStep(step: "notification_screen")
ScateCoreSDK.OnboardingStep(step: "personalization_screen");
ScateCoreSDK.OnboardingStep(step: "journey_screen");
ScateCoreSDK.OnboardingStep(step: "intro_paywall_screen");
ScateCoreSDK.OnboardingStep(step: "fullscreen_ad");
ScateCoreSDK.OnboardingFinish();
```

### Login Event Functions

```swift
ScateCoreSDK.LoginSuccess(source: "apple") 
ScateCoreSDK.LoginSuccess(source: "email")
ScateCoreSDK.LoginSuccess(source: "fb") 
ScateCoreSDK.LoginSuccess(source: "google")
```

### Ad Event Functions

```swift
ScateCoreSDK.InterstitialAdShown()
ScateCoreSDK.InterstitialAdClosed()
ScateCoreSDK.RewardedAdShown()
ScateCoreSDK.RewardedAdClosed()
ScateCoreSDK.RewardedAdClaimed()
ScateCoreSDK.BannerAdShown()
```

### Permission Event Functions

```swift
ScateCoreSDK.NotificationPermissionGranted()
ScateCoreSDK.NotificationPermissionDenied()
ScateCoreSDK.LocationPermissionGranted()
ScateCoreSDK.LocationPermissionDenied()
ScateCoreSDK.ATTPromptShown()
ScateCoreSDK.ATTPermissionGranted()
ScateCoreSDK.ATTPermissionDenied()
```

### Paywall Event Functions

```swift
ScateCoreSDK.PaywallShown(paywall: "paywall_name")
ScateCoreSDK.PaywallClosed(paywall: "paywall_name")
ScateCoreSDK.PaywallAttempted(paywall: "paywall_name")
ScateCoreSDK.PaywallPurchased(paywall: "paywall_name")
ScateCoreSDK.PaywallCancelled(paywall: "paywall_name")
```

### Tab And Feature Event Functions
```swift
ScateCoreSDK.TabClicked(tab: "x")
ScateCoreSDK.FeatureClicked(feature: "x")
```

### Daily Streak Event Functions
```swift
ScateCoreSDK.DailyStreakShown()
ScateCoreSDK.DailyStreakClaimed()
ScateCoreSDK.DailyStreakClosed()
```
