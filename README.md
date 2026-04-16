### Installation 

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

```swift

import SwiftUI
import ScateSDK

@main
struct ScateSDKTestApp: App {
    
    init(){
        
        ScateCoreSDK.Init(appID: "<your app ID>");
        ScateCoreSDK.InitAdjust(adjustToken: "<your adjust token>")

        ScateCoreSDK.GetAdjustId { adid in
            // ADID is non-empty here.
        }
    }

}

```

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

### Send Events

To send events, you can use the following code:

```swift
    
    ScateCoreSDK.Event(name: "button_clicked");

```

### Send Events with Additional Data

```swift

    ScateCoreSDK.Event(name: "button_click", customValue: "subscribe_btn");

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
