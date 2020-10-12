//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal

//MARK: - Container

public final class Container<Program> where Program: App {
	
	//MARK: Properties
	
	public var prompt = ">".magentaForeground()
	
	internal var program: Program
	internal var interpreter: Interpreter
	internal var stack: Stack<Program>
	internal var isRunning = true
	
	//MARK: Computed Properties
	
	public var data: Program.SourceOfTruth {
		get { program.sourceOfTruth }
		set { program.sourceOfTruth = newValue }
	}
	
	//MARK: Initialization
	
	internal init(_ program: Program) {
		self.program = program
		
		interpreter = .init()
		stack = .init()
	}
	
	//MARK: Stack
	
	public func push<S: State>(_ new: S) where S.Program == Program {
		handle {
			try stack.push(new, for: self)
			try sync()
		}
	}
	
	public func pop() {
		handle {
			try stack.pop(for: self)
			try sync()
		}
	}
	
	public func pop<S: State>(to old: S.Type) where S.Program == Program {
		handle {
			try stack.pop(to: old, for: self)
			try sync()
		}
	}
	
	public func replace<S: State>(with new: S) where S.Program == Program {
		handle {
			try stack.replace(with: new, for: self)
			try sync()
		}
	}
	
	public func replace<S1: State, S2: State>(_ old: S1.Type, with new: S2) where S1.Program == Program, S2.Program == Program {
		handle {
			try stack.replace(old, with: new, for: self)
			try sync()
		}
	}
	
	//MARK: Interpreter
	
	@discardableResult
	@inline(__always)
	public func interpret(_ command: String) -> Bool {
		let tmp = handle { return try interpreter.interpret(command) } ?? false
		handle { try stack.state?.step(tmp, self) }
		
		if stack.isEmpty {
			isRunning = false
		}
		
		return tmp
	}
	
	@inline(__always)
	public func handle<T>(_ f: () throws -> T) -> T? {
		interpreter.handle(f)
	}
	
	//MARK: Execution
	
	internal func step() {
		Output.write(prompt + " ")
		let input = Input.readln()
		interpret(input)
	}
	
	internal func run() {
		handle(program.start)
		while isRunning {
			step()
		}
		handle(program.end)
	}
	
	//MARK: Utilities
	
	private func sync() throws {
		interpreter.clear()
		try stack.state?.configure(&interpreter, self)
	}
	
}
