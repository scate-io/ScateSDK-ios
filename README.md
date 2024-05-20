### Installation 

#### CocoaPods

Add following into your Podfile:

```ruby
    pod 'ScateSDK'
```

Example:

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

### Initialize SDK

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

