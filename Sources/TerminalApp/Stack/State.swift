//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - State

public protocol State {
	associatedtype Program: App
	
	static var id: String { get }
	
	/// Called when the State is first added to the stack
	func awake(for container: Container<Program>) throws
	
	/// Called when the State is added to the stack and whenever we pop back to it
	func enter(for container: Container<Program>) throws
	
	/// Called after `enter()` and when a sync is requested; configures the interpreter based on the current application state
	func configure(interpreter: inout Interpreter, for container: Container<Program>) throws
	
	/// Called after every command is executed
	func step(_ success: Bool, for container: Container<Program>) throws
	
	/// Called when the State is about to be removed or another is pushed in front
	func exit(for container: Container<Program>) throws
	
	/// Called when the state is removed from the stack
	func destroy(for container: Container<Program>) throws
	
}

extension State {
	
	//MARK: Defaults
	
	public func awake(for container: Container<Program>) throws { }
	public func enter(for container: Container<Program>) throws { }
	public func exit(for container: Container<Program>) throws { }
	public func destroy(for container: Container<Program>) throws { }
	
	public func step(_ success: Bool, for container: Container<Program>) throws { }
	
	//MARK: Computed Properties
	
	internal var erased: AnyState<Program> { .init(erase: self) }
	
}

//MARK: - Any State

internal struct AnyState<Program> where Program: App {
	
	typealias LifecycleEvent = (Container<Program>) throws -> Void
	
	internal let id: String
	
	private let _awake: LifecycleEvent
	private let _enter: LifecycleEvent
	private let _exit: LifecycleEvent
	private let _destroy: LifecycleEvent
	
	private let _configure: (inout Interpreter, Container<Program>) throws -> Void
	private let _step: (Bool, Container<Program>) throws -> Void
	
	public init<S: State>(erase state: S) where S.Program == Program {
		id = S.id
		
		_awake = state.awake
		_enter = state.enter
		_exit = state.exit
		_destroy = state.destroy
		
		_configure = state.configure
		_step = state.step
	}
	
	public func awake(_ container: Container<Program>) throws { try _awake(container) }
	public func enter(_ container: Container<Program>) throws { try _enter(container) }
	public func exit(_ container: Container<Program>) throws { try _exit(container) }
	public func destroy(_ container: Container<Program>) throws { try _destroy(container) }
	
	public func configure(_ interpreter: inout Interpreter, _ container: Container<Program>) throws {
		try _configure(&interpreter, container)
	}
	
	public func step(_ success: Bool, _ container: Container<Program>) throws {
		try _step(success, container)
	}
	
}
