//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Style

public struct Style {
	
	//MARK: Constants
	
	public static let inherited = Style()
	
	//MARK: Properties
	
	public var foreground = ForegroundColor.inherited
	public var background = BackgroundColor.inherited
	public var decoration = ConsoleDecoration.inherited
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleColor.MAX_ATTRIBUTES * 2 + ConsoleDecoration.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return ControlSequence.SGR(tmp)
	}
	
	//MARK: Initialization
	
	@inlinable public init(
		foreground: ForegroundColor = .plain,
		background: BackgroundColor = .plain,
		decoration: ConsoleDecoration = .inherited
	) {
		self.foreground = foreground
		self.background = background
		self.decoration = decoration
	}
	
	//MARK: Methods
	
	@usableFromInline func build(sequence: inout [UInt8]) {
		foreground.build(sequence: &sequence)
		background.build(sequence: &sequence)
		decoration.build(sequence: &sequence)
	}
	
}
