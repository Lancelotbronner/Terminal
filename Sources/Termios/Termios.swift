//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-23.
//

import Darwin.POSIX.termios

//MARK: - Termios

public struct Termios {
	
	//MARK: Properties
	
	@usableFromInline var underlying: termios
	
	//MARK: Computed Properties
	
	/// The underlying raw value
	@inlinable public var rawValue: termios {
		underlying
	}
	
	/// Describes the basic terminal input control
	@inlinable public var input: Input {
		get { Input(of: underlying) }
		set { newValue.apply(to: &underlying) }
	}
	
	/// Describes the basic terminal output control
	@inlinable public var output: Output {
		get { Output(of: underlying) }
		set { newValue.apply(to: &underlying) }
	}
	
	/// Describes the basic terminal hardware control
	@inlinable public var control: Control {
		get { Control(of: underlying) }
		set { newValue.apply(to: &underlying) }
	}
	
	/// Describes the control of various functions
	@inlinable public var local: Local {
		get { Local(of: underlying) }
		set { newValue.apply(to: &underlying) }
	}
	
	/// Describes the special control characters
	@inlinable public var shortcuts: Shortcuts {
		get { Shortcuts(of: underlying) }
		set { newValue.apply(to: &underlying) }
	}
	
	//MARK: Initialization
	
	/// Wraps an existing `termios` configuration
	@inlinable public init(_ underlying: termios) {
		self.underlying = underlying
	}
	
	/// Retrieves the current configuration of the specified file number
	@inlinable public init(retrieve fileNumber: Int32) {
		// TODO: Error handling
		underlying = termios()
		tcgetattr(fileNumber, &underlying)
	}
	
	/// Retrieves the standard input's current configuration
	@inlinable public static var current: Termios {
		Termios(retrieve: STDIN_FILENO)
	}
	
	//MARK: Methods
	
	/// Applies the configuration to STDIN
	@inlinable public func apply(when schedule: UpdateScheduling = .now) {
		_ = withUnsafePointer(to: underlying) { pointer in
			// TODO: Error handling
			tcsetattr(STDIN_FILENO, schedule.rawValue, pointer)
		}
	}
	
	//MARK: Utilities
	
	@usableFromInline static func retrieve(_ option: Int32, from flags: TermiosFlags) -> Bool {
		flags & TermiosFlags(option) == TermiosFlags(option)
	}
	
	@usableFromInline static func configure(_ option: Int32, to newValue: Bool, into flags: inout TermiosFlags) {
		if newValue {
			flags |= TermiosFlags(option)
		} else {
			flags &= ~TermiosFlags(option)
		}
	}
	
}
