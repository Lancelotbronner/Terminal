// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Terminal",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "Terminal", targets: ["Terminal"]),
        .library(name: "TerminalUI", targets: ["Terminal", "TerminalUI"]),
        .library(name: "TerminalUI2", targets: ["Terminal", "TerminalUI-2"]),
    ],
    targets: [
        .target(name: "Terminal"),
        .target(name: "TerminalUI", dependencies: ["Terminal"]),
        .target(name: "TerminalUI-2", dependencies: ["Terminal"]),
    ]
)
