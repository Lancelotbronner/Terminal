// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Console",
	products: [
		.library(
			name: "Console",
			targets: ["Terminal"]
		),
	],
	targets: [
		.target(name: "Termios"),
		.target(name: "Terminal"),
		
		.target(
			name: "Console",
			dependencies: [
				.target(name: "Termios"),
				.target(name: "Terminal"),
			]
		),
		
		.testTarget(name: "TerminalTests", dependencies: ["Terminal"]),
	]
)
