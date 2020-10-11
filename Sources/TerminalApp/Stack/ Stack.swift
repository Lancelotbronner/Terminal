//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Stack

public struct Stack<SourceOfTruth> {
	
	//MARK: Properties
	
	private var stack: [AnyState<SourceOfTruth>] = []
	
	//MARK: Initialization
	
	internal init() { }
	
	public init<S: State>(_ root: S) where S.SourceOfTruth == SourceOfTruth {
		stack = [root.erased]
	}
	
}
