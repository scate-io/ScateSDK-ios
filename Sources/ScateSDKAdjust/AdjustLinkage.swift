import AdjustSdk

// ScateSDK talks to Adjust through the Objective-C runtime
// (NSClassFromString), so there is nothing to call here — this target's
// only job is to make the package depend on the Adjust SDK so it gets
// linked into every consumer.
//
// The one referenced symbol below keeps the `Adjust` class from being
// dead-stripped in apps that never import AdjustSdk themselves: an ObjC
// class that no code references may never be pulled out of the static
// archive, and the SDK's runtime bridge would then silently do nothing.

/// Anchors the Adjust ObjC classes into the final binary. Apps don't need
/// to touch this; linking the `ScateSDK` product is enough.
public enum ScateSDKAdjustLinkage {
    public static let adjustClass: AnyClass = Adjust.self
}
