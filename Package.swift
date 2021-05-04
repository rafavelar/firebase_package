// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebasePackage",
    platforms: [
          // Only add support for iOS 11 and up.
          .iOS(.v11)
      ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FirebasePackage",
            targets: ["FirebasePackage"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "7.11.0"),
       // .package(url: <#T##String#>, from: <#T##Version#>)
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
                   name: "FirebasePackage",
                   dependencies: [
                           .product(name: "FirebasePackage", package: "Firebase")
                   ]),
        .testTarget(
            name: "FirebasePackageTests",
            dependencies: ["FirebasePackage"]),
    ]
)
