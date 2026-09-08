// swift-tools-version:5.9
import PackageDescription

// Swift Package Manager manifest for the Scate iOS SDK.
//
// The SDK binary is the same ScateSDK.xcframework zip attached to each
// GitHub release (the artifact the podspec points at). The `ScateSDKAdjust`
// wrapper target exists because a binaryTarget cannot declare dependencies:
// it carries the Adjust SDK (with the Google ODM plugin, mirroring the
// podspec's `Adjust/AdjustGoogleOdm` dependency) so every SPM consumer gets
// Adjust linked automatically — ScateSDK reaches it at runtime.
//
// Points at the newest published release artifact. When the release
// automation uploads a new zip, it should also stamp `url` and `checksum`
// below (`swift package compute-checksum <zip>`) before tagging — SPM
// version tags only work when the tagged tree contains this file with the
// matching artifact. Until then, consume via branch "main".

let package = Package(
    name: "ScateSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "ScateSDK", targets: ["ScateSDK", "ScateSDKAdjust"])
    ],
    dependencies: [
        .package(url: "https://github.com/adjust/ios_sdk", from: "5.6.1")
    ],
    targets: [
        .binaryTarget(
            name: "ScateSDK",
            url: "https://github.com/scate-io/ScateSDK-ios/releases/download/v7.0.18/ScateSDK.xcframework-v7.0.18.zip",
            checksum: "f0108eeb4f590e222055e2a62e0aa5fa865e27e204e18da58e5229befef6da1e"
        ),
        .target(
            name: "ScateSDKAdjust",
            dependencies: [
                "ScateSDK",
                .product(name: "AdjustGoogleOdm", package: "ios_sdk")
            ],
            path: "Sources/ScateSDKAdjust"
        )
    ]
)
