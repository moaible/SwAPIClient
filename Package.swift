// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SwAPIClient",
    dependencies: [
        .Package(url: "https://github.com/antitypical/Result.git", majorVersion: 3),
    ]
)
