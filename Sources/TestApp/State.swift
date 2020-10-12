//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal
import TerminalApp

//MARK: - Root

struct Root: State {
	public static let id = "root"
	
	//MARK: Configuration
	
	func configure(interpreter: inout Interpreter, for container: Container<Program>) throws {
		interpreter += Command("toggle", description: "Toggles the value") {
			container.data.toggle()
		}
	}
	
	//MARK: Lifecycle
	
	func enter(for container: Container<Program>) throws {
		status(container)
	}
	
	func step(_ success: Bool, for container: Container<Program>) throws {
		guard success else { return }
		status(container)
	}
	
	//MARK: Methods
	
	func status(_ container: Container<Program>) {
		Output.writeln("The value is \(container.data.description.foreground(.lightMagenta).bold())!")
	}
	
}
