// swift-tools-version:5.5

import PackageDescription

let package = Package.init(
    name: "Automata",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Automata",
            targets: ["Automata"]
        ),
    ],
    targets: [
        .target(
            name: "Automata",
            dependencies: []
        ),
        .testTarget(
            name: "AutomataTests",
            dependencies: ["Automata"]
        ),
    ]
)
