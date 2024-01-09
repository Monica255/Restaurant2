// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", branch: "main"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
        .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
        .package(path: "../Core"),
        .package(path: "../Home"),
        .package(path: "../Detail")
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Favorite",
            dependencies: [
                "RxSwift",
                "Alamofire",
                .product(name: "RealmSwift", package: "realm-swift"),
                "Core",
                "Home",
                "Detail"
            ]),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite"]),
    ]
)
