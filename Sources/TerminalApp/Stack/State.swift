//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - State

public protocol State {
	associatedtype SourceOfTruth
	
	/// Called when the State is first added to the stack
	func awake()
	
	/// Called when the State is added to the stack and whenever we pop back to it
	func enter()
	
	/// Called after `enter()` and when a sync is requested; configures the interpreter based on the current application state
	func configure(interpreter: inout Interpreter<SourceOfTruth>, for app: inout SourceOfTruth) throws
	
	/// Called when the State is about to be removed or another is pushed in front
	func exit()
	
	/// Called when the state is removed from the stack
	func destroy()
	
}

extension State {
	
	internal var erased: AnyState<SourceOfTruth> { .init(erase: self) }
	
}

//MARK: - Any State

internal struct AnyState<SourceOfTruth> {
	
	private let _awake: () -> Void
	private let _enter: () -> Void
	private let _exit: () -> Void
	private let _destroy: () -> Void
	
	private let _configure: (inout Interpreter<SourceOfTruth>, inout SourceOfTruth) throws -> Void
	
	public init<S: State>(erase state: S) where S.SourceOfTruth == SourceOfTruth {
		_awake = state.awake
		_enter = state.enter
		_exit = state.exit
		_destroy = state.destroy
		
		_configure = state.configure
	}
	
}
