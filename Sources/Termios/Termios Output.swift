//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-25.
//

import Darwin.POSIX.termios

//MARK: - Termios Output

extension Termios {
	public struct Output {
		
		//MARK: Properties
		
		@usableFromInline var underlying: TermiosFlags
		
		//MARK: Computed Properties
		
		/// Wether output is processed or displayed as-is, controls wether any other output processing is enabled
		@inlinable public var isProcessingEnabled: Bool {
			get { retrieve(OPOST) }
			set { configure(OPOST, to: newValue) }
		}
		
		/// Wether newlines are translated to carriage return, linefeed
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var insertCarriageReturnOnLinefeed: Bool {
			get { retrieve(ONLCR) }
			set { configure(ONLCR, to: newValue) }
		}
		
		/// Wether tabs are expanded to 8 spaces
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var expandTabs: Bool {
			get { retrieve(OXTABS) }
			set { configure(OXTABS, to: newValue) }
		}
		
		/// Wether `EOT` should be discarded
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var ignoreEndOfTransmission: Bool {
			get { retrieve(OXTABS) }
			set { configure(OXTABS, to: newValue) }
		}
		
		/// Wether carriage returns are translated to linefeeds
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var convertCarriageReturnToLinefeed: Bool {
			get { retrieve(OCRNL) }
			set { configure(OCRNL, to: newValue) }
		}
		
		/// Wether to discard carriage returns when the cursor is already at column 0
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var discardUselessCarriageReturns: Bool {
			get { retrieve(ONOCR) }
			set { configure(ONOCR, to: newValue) }
		}
		
		/// Wether to interpret linefeeds as also doing a carriage return
		///
		/// This has no effect if ``isOutputPreprocessed`` is `false`.
		@inlinable public var shouldReturnOnLinefeed: Bool {
			get { retrieve(ONOCR) }
			set { configure(ONOCR, to: newValue) }
		}
		
		//MARK: Initialization
		
		@usableFromInline init(of terminal: termios) {
			underlying = terminal.c_oflag
		}
		
		//MARK: Methods
		
		@usableFromInline func apply(to terminal: inout termios) {
			terminal.c_oflag = underlying
		}
		
		@usableFromInline func retrieve(_ option: Int32) -> Bool {
			Termios.retrieve(option, from: underlying)
		}
		
		@usableFromInline mutating func configure(_ option: Int32, to newValue: Bool) {
			Termios.configure(option, to: newValue, into: &underlying)
		}
		
	}
}
