//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal

//MARK: - App Protocol

public protocol App {
	
	/// Initializes the application. The stack isn't available yet.
	init() throws
	
	/// Called before anything else when the application starts
	func start()
	
	/// Called when the root `State` is popped just before the program exits
	func end()
	
}

extension App {
	
	//MARK: Defaults
	
	public func end() { }
	
	//MARK: Properties
	
	internal var container: Container<Self> {
		get { TerminalApp.container() }
		set { TerminalApp.container(set: newValue) }
	}
	
	public var stack: Stack<Self> {
		get { container.stack }
		set { container.stack = newValue }
	}
	
	//MARK: Methods
	
	/// Exits the application
	public mutating func exit() {
		container.isRunning = false
	}
	
	//MARK: Main
	
	public static func main() throws {
		var app = try Self.init()
		app.container = Container<Self>(app) { app = $0 }
		app.run()
	}
	
	private mutating func run() {
		start()
		while container.isRunning {
			let input = Input.prompt()
			do { try container.interpreter.interpret(input, on: &self) }
			catch {
				"\(error)"
					.foreground(.red)
					.outputln()
			}
		}
		end()
	}
	
}
