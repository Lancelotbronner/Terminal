//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-23.
//

import Darwin

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
	
	//MARK: Initialization
	
	/// Wraps an existing `termios` configuration
	@inlinable public init(_ underlying: termios) {
		self.underlying = underlying
	}
	
	@usableFromInline init() { // TODO: Error handling
		underlying = termios()
		tcgetattr(STDIN_FILENO, &underlying)
	}
	
	/// Retrieves the current configuration of STDIN
	@inlinable public static var current: Termios {
		Termios()
	}
	
	//MARK: Methods
	
	/// Applies the configuration to STDIN
	@inlinable public func apply(when schedule: UpdateScheduling = .now) {
		_ = withUnsafePointer(to: underlying) { pointer in // TODO: Error handling
			tcsetattr(STDIN_FILENO, schedule.rawValue, pointer)
		}
	}
	
	//MARK: Utilities
	
	@usableFromInline static func retrieve(_ option: Int32, from flags: tcflag_t) -> Bool {
		flags & tcflag_t(option) == tcflag_t(option)
	}
	
	@usableFromInline static func configure(_ option: Int32, to newValue: Bool, into flags: inout tcflag_t) {
		if newValue {
			flags |= tcflag_t(option)
		} else {
			flags &= ~tcflag_t(option)
		}
	}
	
	//MARK: Update Scheduling Options
	
	public enum UpdateScheduling {
		/// The change should take place immediately.
		case now
		
		/// The change should take place after all output written has been read by the master pseudoterminal. Use this value when changing terminal attributes that affect output.
		case drain
		
		/// The change should take place after all output written has been sent; in addition, all input that has been received but not read should be discarded (flushed) before the change is made.
		case flush
		
		@usableFromInline var rawValue: Int32 {
			switch self {
			case .now: return TCSANOW
			case .drain: return TCSADRAIN
			case .flush: return TCSAFLUSH
			}
		}
	}
	
}
