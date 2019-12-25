// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Terminal",
    products: [
        .library(name: "Terminal", targets: ["Terminal"]),
        .library(name: "TerminalUI", targets: ["Terminal", "TerminalUI"]),
    ],
    targets: [
        .target(name: "Terminal"),
        .target(name: "TerminalUI", dependencies: ["Terminal"]),
    ]
)
