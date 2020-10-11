//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Container

internal struct Container<SourceOfTruth> {
	
	//MARK: Properties
	
	private let _get: () -> SourceOfTruth
	private let _set: (SourceOfTruth) -> Void
	
	internal var isRunning = true
	internal var interpreter: Interpreter<SourceOfTruth>
	internal var stack: Stack<SourceOfTruth>
	
	//MARK: Computed Properties
	
	internal var data: SourceOfTruth {
		get { _get() }
		set { _set(newValue) }
	}
	
	//MARK: Initialization
	
	internal init(_ get: @autoclosure @escaping () -> SourceOfTruth, _ set: @escaping (SourceOfTruth) -> Void) {
		_get = get
		_set = set
		
		interpreter = .init()
		stack = .init()
	}
	
}
