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
        
        // ...
        // It's better to initialize the SDK after Adjust SDK 

        ScateCoreSDK.Init(appID: "<your app ID>");
        // make sure to set adid from Adjust SDK
        let adid = Adjust.adid()
        ScateCoreSDK.SetAdid(adid: adid);
    }
    
}

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



