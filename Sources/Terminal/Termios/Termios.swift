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
	
	//MARK: Initialization
	
	@inlinable public init(wrap underlying: termios) {
		self.underlying = underlying
	}
	
	@usableFromInline internal init() {
		underlying = termios()
		tcgetattr(STDIN_FILENO, &underlying)
	}
	
	@inlinable public static var current: Termios { .init() }
	
	//MARK: Static Methods
	
	@inlinable public static func restore(when schedule: UpdateScheduling = .now) {
		apply(mode: backup, when: schedule)
	}
	
	@usableFromInline internal static func apply(mode: termios, when schedule: UpdateScheduling) {
		withUnsafePointer(to: mode) { pointer in
			tcsetattr(STDIN_FILENO, schedule.rawValue, pointer)
		}
	}
	
	//MARK: Methods
	
	@inlinable public func store() {
		Termios.backup = underlying
	}
	
	@inlinable public func apply(when schedule: UpdateScheduling = .now) {
		Termios.current.store()
		Termios.apply(mode: underlying, when: schedule)
	}
	
	//MARK: Utilities
	
	@usableFromInline func retrieve(option: Int32, from flags: KeyPath<termios, tcflag_t>) -> Bool {
		underlying[keyPath: flags] & tcflag_t(option) == tcflag_t(option)
	}
	
	@usableFromInline mutating func configure(option: Int32, to newValue: Bool, into flags: WritableKeyPath<termios, tcflag_t>) {
		if newValue {
			underlying[keyPath: flags] |= tcflag_t(option)
		} else {
			underlying[keyPath: flags] &= ~tcflag_t(option)
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
