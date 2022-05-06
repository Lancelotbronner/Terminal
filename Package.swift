// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Terminal",
	products: [
		.library(name: "Terminal", targets: ["Terminal"]),
	],
	targets: [
		.target(name: "Termios"),
		.target(name: "ControlSequence"),
		.target(name: "Prompt"),
		
			.target(
				name: "Terminal",
				dependencies: [
					.target(name: "Termios"),
					.target(name: "ControlSequence")
				]),
		
//		.target(name: "TerminalApp", dependencies: ["Terminal"]),
		
//			.target(name: "TestApp", dependencies: ["TerminalApp"]),
		
			.testTarget(name: "TerminalTests", dependencies: ["Terminal"]),
	]
)

// Beat:
// [ Terminal ] ANSITerminal, swift-commandline-kit
// [ Styling ] ColorizeSwift, Rainbow, ANSITerminal
// [ CLI ] vapor/ConsoleKit, swift-argument-parser, swift-commandline-kit
// [ UI ] TermKit, Ashen
// [ REPL ] ConsoleKit, replxx
