//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - App Protocol

public protocol App {
	associatedtype SourceOfTruth
	
	/// The program's state
	var sourceOfTruth: SourceOfTruth { get set }
	
	/// Initializes the application. The stack isn't available yet.
	init() throws
	
	/// Called before anything else when the application starts
	func start() throws
	
	/// Called when the root `State` is popped just before the program exits
	func end() throws
	
}

extension App {
	
	//MARK: Defaults
	
	public func start() throws { }
	public func end() throws { }
	
	//MARK: Properties
	
	public private(set) var container: Container<Self> {
		get { TerminalApp.container() }
		set { TerminalApp.container(set: newValue) }
	}
	
	//MARK: Methods
	
	/// Exits the application
	public mutating func exit() {
		container.isRunning = false
	}
	
	//MARK: Main
	
	public static func main() throws {
		var app = try Self.init()
		app.container = Container<Self>(app)
		app.run()
	}
	
	private mutating func run() {
		container.run()
	}
	
}
