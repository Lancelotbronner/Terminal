//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-25.
//

//MARK: - C0 Control Codes

extension ControlSequence {
	
	/// `Null`: Ignored
	public static let NUL: Character = "\u{00}"
	
	/// `Bell` Ring the bell
	public static let BEL: Character = "\u{07}"
	
	/// `Backspace`: Moves the cursor left
	///
	/// By default it is not possible to move the cursor past the leftmost position. If reverse wrap-around (CSI ? 45 h) is set, a previous soft
	/// line wrap (DECAWM) can be undone with BS within the scroll margins. In that case the cursor will wrap back to the end of the
	/// previous row. Note that it is not possible to peek back into the scrollbuffer with the cursor, thus at the home position
	/// (top-leftmost cell) this has no effect.
	public static let BS: Character = "\u{08}"
	
	/// `Horizontal Tabulation`: Move the cursor to the next character tab stop
	public static let HT: Character = "\u{09}"
	
	/// `Linefeed`: Move the cursor one row down, scrolling if needed
	///
	/// Scrolling is restricted to scroll margins and will only happen on the bottom line.
	public static let LF: Character = "\u{0A}"
	
	/// `Vertical Tabulation`
	public static let VT: Character = "\u{0B}"
	
	/// `Formfeed`
	public static let FF: Character = "\u{0C}"
	
	/// `Carriage Return`: Move the cursor to the beginning of the row
	public static let CR: Character = "\u{0D}"
	
	/// `Shift Out`: Switch to an alternative character set
	public static let SO: Character = "\u{0E}"
	
	/// `Shift Out`: Return to regular character set after ``SO``
	public static let SI: Character = "\u{0F}"
	
	/// Starts an escape sequence
	public static let ESC: Character = "\u{1B}"
	
}
