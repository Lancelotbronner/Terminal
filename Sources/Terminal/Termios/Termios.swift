//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-23.
//

import Darwin

//MARK: - Termios

public struct Termios {
	
	//MARK: Typealiases
	
	@usableFromInline typealias Retrieve = (Int32, KeyPath<termios, tcflag_t>) -> Bool
	@usableFromInline typealias Configure = (Int32, Bool, WritableKeyPath<termios, tcflag_t>) -> Void
	
	//MARK: Static Properties
	
	@usableFromInline internal static var backup: termios = {
		print("INITIAL")
		
		// Register restore on exit
		atexit { Termios.apply(mode: initial, when: .flush) }
		
		// Return (lazy-initialized) initial configuration
		return initial
	}()
	
	//MARK: Properties
	
	@usableFromInline internal var underlying: termios
	
	//MARK: Computed Properties
	
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
	
	@inlinable public init(wrap underlying: termios) {
		self.underlying = underlying
	}
	
	@usableFromInline internal init() { // TODO: Error handling
		underlying = termios()
		tcgetattr(STDIN_FILENO, &underlying)
	}
	
	@inlinable public static var current: Termios { .init() }
	
	//MARK: Static Methods
	
	@inlinable public static func restore(when schedule: UpdateScheduling = .now) {
		apply(mode: backup, when: schedule)
	}
	
	@usableFromInline internal static func apply(mode: termios, when schedule: UpdateScheduling = .now) {
		_ = withUnsafePointer(to: mode) { pointer in // TODO: Error handling
			tcsetattr(STDIN_FILENO, schedule.rawValue, pointer)
		}
	}
	
	//MARK: Methods
	
	@inlinable public func apply(when schedule: UpdateScheduling = .now) {
		Termios.backup = underlying
		Termios.apply(mode: underlying, when: schedule)
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

private let initial = Termios.current.underlying
