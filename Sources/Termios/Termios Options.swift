//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-01-04.
//

import Darwin.POSIX.termios

extension Termios {
	
	//MARK: - Character Size
	
	public enum CharacterSize: RawRepresentable {
		case five
		case six
		case seven
		case eight
		
		//MARK: Computed Properties
		
		@inlinable public var bits: Int {
			switch self {
			case .five: return 5
			case .six: return 6
			case .seven: return 7
			case .eight: return 8
			}
		}
		
		@inlinable public var rawValue: Int32 {
			switch self {
			case .five: return CS5
			case .six: return CS6
			case .seven: return CS7
			case .eight: return CS8
			}
		}
		
		@inlinable public init?(rawValue: Int32) {
			switch rawValue {
			case CS5: self = .five
			case CS6: self = .six
			case CS7: self = .seven
			case CS8: self = .eight
			default: return nil
			}
		}
		
	}
	
	//MARK: - Parity
	
	public enum Parity: RawRepresentable {
		case even
		case odd
		
		@inlinable public var rawValue: Bool {
			self == .odd
		}
		
		@inlinable public init(rawValue: Bool) {
			self = rawValue ? .odd : .even
		}
		
	}
	
	//MARK: - Update Scheduling Options
	
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
	
	//MARK: - Control Characters
	
	public typealias CC = (
		eof: cc_t,
		eol: cc_t,
		eol2: cc_t,
		erase: cc_t,
		werase: cc_t,
		kill: cc_t,
		reprint: cc_t,
		interrupt: cc_t,
		quit: cc_t,
		suspend: cc_t,
		dsuspend: cc_t,
		start: cc_t,
		stop: cc_t,
		lnext: cc_t,
		discard: cc_t,
		min: cc_t,
		time: cc_t,
		status: cc_t,
		cc_t, cc_t)
	
}
