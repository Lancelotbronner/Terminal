//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Stack

internal struct Stack<Program> where Program: App {
	
	//MARK: Properties
	
	private var stack: [AnyState<Program>] = []
	
	//MARK: Computed Properties
	
	public var isEmpty: Bool { stack.isEmpty }
	
	internal var state: AnyState<Program>? { stack.last }
	
	//MARK: Initialization
	
	internal init() { }
	
	public init<S: State>(_ root: S) where S.Program == Program {
		stack = [root.erased]
	}
	
	//MARK: Methods
	
	public mutating func push<S: State>(_ new: S, for container: Container<Program>) throws where S.Program == Program {
		try state?.exit(container)
		try _push(new.erased, for: container)
	}
	
	public mutating func pop(for container: Container<Program>) throws {
		try _pop(for: container)
		try state?.enter(container)
	}
	
	public mutating func pop<S: State>(to old: S.Type, for container: Container<Program>) throws where S.Program == Program {
		try _pop(until: old, for: container)
		try state?.enter(container)
	}
	
	public mutating func replace<S: State>(with new: S, for container: Container<Program>) throws where S.Program == Program {
		try _pop(for: container)
		try _push(new.erased, for: container)
	}
	
	public mutating func replace<S1: State, S2: State>(_ old: S1.Type, with new: S2, for container: Container<Program>) throws where S1.Program == Program, S2.Program == Program {
		try _pop(until: old, for: container)
		try _push(new.erased, for: container)
	}
	
	//MARK: Utilities
	
	private mutating func _pop(for container: Container<Program>) throws {
		try state?.exit(container)
		try state?.destroy(container)
		stack.removeLast()
	}
	
	private mutating func _push(_ new: AnyState<Program>, for container: Container<Program>) throws {
		stack.append(new)
		try state?.awake(container)
		try state?.enter(container)
	}
	
	private mutating func _pop<S: State>(until: S.Type, for container: Container<Program>) throws where S.Program == Program {
		while state?.id != S.id {
			try _pop(for: container)
		}
	}
	
}
