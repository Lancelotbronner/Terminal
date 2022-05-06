//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Darwin.POSIX.termios

//MARK: - Termios Shortcuts

extension Termios {
	public struct Shortcuts {
		
		//MARK: Constants
		
		#if os(macOS)
		@inlinable public static var disabled: cc_t { .max }
		#elseif os(Linux)
		@inlinable public static var disabled: cc_t { .zero }
		#endif
		
		//MARK: Properties
		
		@usableFromInline var underlying: CC
		
		//MARK: Computed Properties
		
		@inlinable public var eof: Unicode.Scalar? {
			get { retrieve(\.eof) }
			set { configure(\.eof, to: newValue) }
		}
		
		// TODO: VEOL
		// TODO: VEOL2
		// TODO: VERASE
		// TODO: VWERASE
		// TODO: VKILL
		// TODO: VREPRINT
		// TODO: VINTR
		// TODO: VQUIT
		// TODO: VSUSP
		// TODO: VDSUSP
		// TODO: VSTART
		// TODO: VSTOP
		// TODO: VLNEXT
		// TODO: VDISCARD
		// TODO: VMIN
		// TODO: VTIME
		// TODO: VSTATUS
		
		//MARK: Initialization
		
		@usableFromInline init(of terminal: termios) {
			underlying = terminal.c_cc
		}
		
		//MARK: Methods
		
		@usableFromInline func apply(to terminal: inout termios) {
			terminal.c_cc = underlying
		}
		
		@usableFromInline func retrieve(_ option: KeyPath<CC, cc_t>) -> Unicode.Scalar? {
			let tmp = underlying[keyPath: option] == Shortcuts.disabled ? nil : underlying[keyPath: option]
			return tmp.map(Unicode.Scalar.init)
		}
		
		@usableFromInline mutating func configure(_ option: WritableKeyPath<CC, cc_t>, to newValue: Unicode.Scalar?) {
			assert(newValue.map { $0.value < UInt32(UInt8.max) } ?? true, "Character must be ascii (0 to 255), in release mode the value will be truncated")
			underlying[keyPath: option] = newValue.map(\.value).map(UInt8.init(truncatingIfNeeded:)) ?? Shortcuts.disabled
		}
		
	}
}

/*
 Special Control Characters
 The special control characters values are defined by the array c_cc.  This table lists the array index, the corresponding special character, and the system default value.  For an accurate list of the system
 defaults, consult the header file ⟨ttydefaults.h⟩.
 
 Index Name    Special Character    Default Value
 VEOF          EOF                  ^D
 VEOL          EOL                  _POSIX_VDISABLE
 VEOL2         EOL2                 _POSIX_VDISABLE
 VERASE        ERASE                ^? ‘\177’
 VWERASE       WERASE               ^W
 VKILL         KILL                 ^U
 VREPRINT      REPRINT              ^R
 VINTR         INTR                 ^C
 VQUIT         QUIT                 ^\\ ‘\34’
 VSUSP         SUSP                 ^Z
 VDSUSP        DSUSP                ^Y
 VSTART        START                ^Q
 VSTOP         STOP                 ^S
 VLNEXT        LNEXT                ^V
 VDISCARD      DISCARD              ^O
 VMIN          ---                  1
 VTIME         ---                  0
 VSTATUS       STATUS               ^T
 
 If the value of one of the changeable special control characters (see Special Characters) is {_POSIX_VDISABLE}, that function is disabled; that is, no input data is recognized as the disabled special character.  If
 ICANON is not set, the value of {_POSIX_VDISABLE} has no special meaning for the VMIN and VTIME entries of the c_cc array.
 
 The initial values of the flags and control characters after open() is set according to the values in the header ⟨sys/ttydefaults.h⟩.
 */
