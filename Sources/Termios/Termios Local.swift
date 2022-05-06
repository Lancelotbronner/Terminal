//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Darwin.POSIX.termios

//MARK: - Termios Local

extension Termios {
	public struct Local {
		
		//MARK: Properties
		
		@usableFromInline var underlying: TermiosFlags
		
		//MARK: Computed Properties
		
		/// Input characters are echoed back to the terminal
		@inlinable public var echo: Bool {
			get { retrieve(ECHO) }
			set { configure(ECHO, to: newValue) }
		}
		
		/// Wether to always echo newlines regardless of ``echo``'s value
		///
		/// This has no effect if ``isCanonical`` is `false`
		@inlinable public var alwaysEchoNewlines: Bool {
			get { retrieve(ECHONL) }
			set { configure(ECHONL, to: newValue) }
		}
		
		/// Allows erasing lines with the special character ``Shortcuts.eraseLine``
		///
		/// This has no effect if ``isCanonical`` is `false`
		@inlinable public var canEraseLine: Bool {
			get { retrieve(ECHOKE) }
			set { configure(ECHOKE, to: newValue) }
		}
		
		/// Allows erasing the last character of the current line with the special character ``Shortcuts.eraseCharacter``
		///
		/// This has no effect if ``isCanonical`` is `false`
		@inlinable public var canEraseCharacter: Bool {
			get { retrieve(ECHOE) }
			set { configure(ECHOE, to: newValue) }
		}
		
		/// Allows discarding lines with the special character ``Shortcuts.eraseLine``
		///
		/// Note that **visually**, this is the equivalent of a linefeed. To erase the line from the display, enable ``canEraseLine`` instead.
		///
		/// This has no effect if ``isCanonical`` is `false`
		@inlinable public var canDiscardLine: Bool {
			get { retrieve(ECHOK) }
			set { configure(ECHOK, to: newValue) }
		}
		
		/// Processes input line by line, allows manipulating the line before submitting it
		@inlinable public var isCanonical: Bool {
			get { retrieve(ICANON) }
			set { configure(ICANON, to: newValue) }
		}
		
		/// This assumes the output is a printer and will wrap the erased characters with a backslash and forward slash
		@inlinable public var describeErase: Bool {
			get { retrieve(ECHOPRT) }
			set { configure(ECHOPRT, to: newValue) }
		}
		
		/// Displays control characters by prepending a caret, such as `^C` for control-C
		@inlinable public var describeControlCharacters: Bool {
			get { retrieve(ECHOCTL) }
			set { configure(ECHOCTL, to: newValue) }
		}
		
		/// Selects which word erasing algorithm to use.
		///
		/// If this is `false`, whitespace is erased, and then the maximal sequence of non-whitespace characters.
		///
		/// If this is `true`, first any preceding whitespace is erased, and then the maximal sequence of alphabetic/underscores or non alphabetic/underscores.
		/// As a special case in this second algorithm, the first previous non-whitespace character is skipped in determining whether the preceding word is a sequence
		/// of alphabetic/undercores. This sounds confusing but turns out to be quite practical.
		@inlinable public var useAlternateWordEraseAlgorithm: Bool {
			get { retrieve(ALTWERASE) }
			set { configure(ALTWERASE, to: newValue) }
		}
		
		/// Wether to process interrupts from ``Shortcuts.interrupt``, kills from ``Shortcuts.kill`` and suspensions from ``Shortcuts.suspend``
		@inlinable public var isProcessControlEnabled: Bool {
			get { retrieve(ISIG) }
			set { configure(ISIG, to: newValue) }
		}
		
		/// Wether to flush the input and output queues before doing process control functions
		///
		/// This has no effect if ``isProcessControlEnabled`` is `false`
		@inlinable public var preventFlushOnProcessControl: Bool {
			get { retrieve(Int32(bitPattern: NOFLSH)) }
			set { configure(Int32(bitPattern: NOFLSH), to: newValue) }
		}
		
		/// Wether to allow implementation-defined extended functionnality
		@inlinable public var areExtensionsEnabled: Bool {
			get { retrieve(IEXTEN) }
			set { configure(IEXTEN, to: newValue) }
		}
		
		//MARK: Initialization
		
		@usableFromInline init(of terminal: termios) {
			underlying = terminal.c_lflag
		}
		
		//MARK: Methods
		
		@usableFromInline func apply(to terminal: inout termios) {
			terminal.c_lflag = underlying
		}
		
		@usableFromInline func retrieve(_ option: Int32) -> Bool {
			Termios.retrieve(option, from: underlying)
		}
		
		@usableFromInline mutating func configure(_ option: Int32, to newValue: Bool) {
			Termios.configure(option, to: newValue, into: &underlying)
		}
		
	}
}

/*
 Local Modes
 Values of the c_lflag field describe the control of various functions, and are composed of the following masks.
 
 ECHOKE      /* visual erase for line kill */
 ECHOE       /* visually erase chars */
 ECHO        /* enable echoing */
 ECHONL      /* echo NL even if ECHO is off */
 ECHOPRT     /* visual erase mode for hardcopy */
 ECHOCTL     /* echo control chars as ^(Char) */
 ISIG        /* enable signals INTR, QUIT, [D]SUSP */
 ICANON      /* canonicalize input lines */
 ALTWERASE   /* use alternate WERASE algorithm */
 IEXTEN      /* enable DISCARD and LNEXT */
 EXTPROC     /* external processing */
 TOSTOP      /* stop background jobs from output */
 FLUSHO      /* output being flushed (state) */
 NOKERNINFO  /* no kernel output from VSTATUS */
 PENDIN      /* XXX retype pending input (state) */
 NOFLSH      /* don't flush after interrupt */
 
 If ECHO is set, input characters are echoed back to the terminal.  If ECHO is not set, input characters are not echoed.
 
 If ECHOE and ICANON are set, the ERASE character causes the terminal to erase the last character in the current line from the display, if possible.  If there is no character to erase, an implementation may echo an
 indication that this was the case or do nothing.
 
 If ECHOK and ICANON are set, the KILL character causes the current line to be discarded and the system echoes the ‘\n’ character after the KILL character.
 
 If ECHOKE and ICANON are set, the KILL character causes the current line to be discarded and the system causes the terminal to erase the line from the display.
 
 If ECHOPRT and ICANON are set, the system assumes that the display is a printing device and prints a backslash and the erased characters when processing ERASE characters, followed by a forward slash.
 
 If ECHOCTL is set, the system echoes control characters in a visible fashion using a caret followed by the control character.
 
 If ALTWERASE is set, the system uses an alternative algorithm for determining what constitutes a word when processing WERASE characters (see WERASE).
 
 If ECHONL and ICANON are set, the ‘\n’ character echoes even if ECHO is not set.
 
 If ICANON is set, canonical processing is enabled.  This enables the erase and kill edit functions, and the assembly of input characters into lines delimited by NL, EOF, and EOL, as described in Canonical Mode Input
 Processing.
 
 If ICANON is not set, read requests are satisfied directly from the input queue.  A read is not satisfied until at least MIN bytes have been received or the timeout value TIME expired between bytes.  The time value
 represents tenths of seconds.  See Noncanonical Mode Input Processing for more details.
 
 If ISIG is set, each input character is checked against the special control characters INTR, QUIT, and SUSP (job control only).  If an input character matches one of these control characters, the function associated
 with that character is performed.  If ISIG is not set, no checking is done.  Thus these special input functions are possible only if ISIG is set.
 
 If IEXTEN is set, implementation-defined functions are recognized from the input data.  How IEXTEN being set interacts with ICANON, ISIG, IXON, or IXOFF is implementation defined.  If IEXTEN is not set, then
 implementation-defined functions are not recognized, and the corresponding input characters are not processed as described for ICANON, ISIG, IXON, and IXOFF.
 
 If NOFLSH is set, the normal flush of the input and output queues associated with the INTR, QUIT, and SUSP characters are not be done.
 
 If ICANON is set, an upper case character is preserved on input if prefixed by a \ character.  In addition, this prefix is added to upper case characters on output.
 
 In addition, the following special character translations are in effect:
 
 for:    use:
 `       \'
 |       \!
 ~       \^
 {       \(
 }       \)
 \       \\
 
 If TOSTOP is set, the signal SIGTTOU is sent to the process group of a process that tries to write to its controlling terminal if it is not in the foreground process group for that terminal.  This signal, by
 default, stops the members of the process group.  Otherwise, the output generated by that process is output to the current output stream.  Processes that are blocking or ignoring SIGTTOU signals are excepted and
 allowed to produce output and the SIGTTOU signal is not sent.
 
 If NOKERNINFO is set, the kernel does not produce a status message when processing STATUS characters (see STATUS).
 */
