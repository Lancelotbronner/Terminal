//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - CSI Sequences

extension ControlSequence {
	
	/// `Insert Characters`: Inserts blank characters
	///
	/// The cursor remains at the beginning of the blank characters. Text between the cursor and right margin moves to the right.
	/// Characters moved past the right margin are lost.
	@inlinable public static func ICH(_ cells: Int) -> String {
		"\(CSI)\(cells)@"
	}
	
	/// `Scroll Left`: Scroll viewport to the left
	///
	/// Moves the content of all lines within the scroll margins to the left. Has no effect outside of the scroll margins.
	@inlinable public static func SL(_ lines: Int) -> String {
		"\(CSI)\(lines) @"
	}
	
	/// `Cursor Up`: Moves the cursor up `n` cells
	///
	/// If the cursor is already at the edge of the screen, this has no effect.
	@inlinable public static func CUU(_ cells: Int) -> String {
		"\(CSI)\(cells)A"
	}
	
	/// `Scroll Right`: Scroll viewport to the right
	///
	/// Moves the content of all lines within the scroll margins to the right. Has no effect outside of the scroll margins.
	@inlinable public static func SR(_ lines: Int) -> String {
		"\(CSI)\(lines) T"
	}
	
	/// `Cursor Down`: Moves the cursor down `n` cells
	///
	/// If the cursor is already at the edge of the screen, this has no effect.
	@inlinable public static func CUD(_ cells: Int) -> String {
		"\(CSI)\(cells)B"
	}
	
	/// `Cursor Forward`: Moves the cursor forward `n` cells
	///
	/// If the cursor is already at the edge of the screen, this has no effect.
	@inlinable public static func CUF(_ cells: Int) -> String {
		"\(CSI)\(cells)C"
	}
	
	/// `Cursor Backward`: Moves the cursor back `n` cells
	///
	/// If the cursor is already at the edge of the screen, this has no effect.
	@inlinable public static func CUB(_ cells: Int) -> String {
		"\(CSI)\(cells)D"
	}
	
	/// `Cursor Next Line`: Moves the cursor to the beginning of line `n` lines down
	@inlinable public static func CNL(_ line: Int) -> String {
		"\(CSI)\(line)E"
	}
	
	/// `Cursor Previous Line`: Moves the cursor to the beginning of line `n` lines up
	@inlinable public static func CPL(_ line: Int) -> String {
		"\(CSI)\(line)F"
	}
	
	/// `Cursor Horizontal Absolute`: Moves the cursor to column `n`
	@inlinable public static func CHA(_ column: Int) -> String {
		"\(CSI)\(column)G"
	}
	
	/// `Cursor Position`: Moves the cursor to row `n`, column `m`
	///
	/// The values are 1-based
	@inlinable public static func CUP(_ row: Int, _ column: Int) -> String {
		"\(CSI)\(row);\(column)H"
	}
	
	//TODO: CHT
	
	/// `Erase In Display`: Clears part of the screen
	///
	/// The valid values for `mode` are:
	///  - `0` clear from cursor to end of screen
	///  - `1` clear from cursor to beginning of the screen
	///  - `2` clear entire screen
	///  - `3` clear entire screen and delete all lines saved in the scrollback buffer
	@inlinable public static func ED(_ mode: Int) -> String {
		"\(CSI)\(mode)J"
	}
	
	//TODO: DECSED
	
	/// `Erase In Line`: Erases part of the line
	///
	/// The valid values for `mode` are:
	///  - `0` clear from cursor to the end of the line
	///  - `1` clear from cursor to beginning of the line
	///  - `2` clear entire line
	///
	/// Cursor position does not change.
	@inlinable public static func EL(_ mode: Int) -> String {
		"\(CSI)\(mode)K"
	}
	
	//TODO: DECSEL
	//TODO: IL
	//TODO: DL
	//TODO: DCH
	
	/// `Scroll Up`: Scroll whole page up by `n` lines
	///
	/// New lines are added at the bottom.
	@inlinable public static func SU(_ lines: Int) -> String {
		"\(CSI)\(lines)S"
	}
	
	/// `Scroll Down`: Scroll whole page down by `n` lines
	///
	/// New lines are added at the top.
	@inlinable public static func SD(_ lines: Int) -> String {
		"\(CSI)\(lines)T"
	}
	
	//TODO: ECH
	//TODO: CBT
	//TODO: HPA
	//TODO: HPR
	//TODO: REP
	//TODO: DA1
	//TODO: DA2
	//TODO: VPA
	//TODO: VPR
	
	/// `Horizontal and Vertical Position`: Same as ``CUP(_:_:)`` but counts as a format effector function rather than an editor function
	///
	/// This can lead to different handling in certain terminal modes.
	@inlinable public static func HVP(_ row: Int, _ column: Int) -> String {
		"\(CSI)\(row);\(column)f"
	}
	
	//TODO: TBC
	//TODO: SM
	//TODO: DECSET
	//TODO: DECRST
	
	/// `Select Graphic Rendition`: Resets colors and style of the characters following this code
	public static let SGR = "\(CSI)m"
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(_ parameters: [UInt8]) -> String {
		"\(CSI)\(parameters.lazy.map(\.description).joined(separator: ";"))m"
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(_ parameters: UInt8...) -> String {
		SGR(parameters)
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(bit8 n: UInt8) -> String {
		SGR(n)
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(fg256 n: UInt8) -> String {
		SGR(38, 5, n)
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(bg256 n: UInt8) -> String {
		SGR(48, 5, n)
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(fgRGB r: UInt8, _ g: UInt8, _ b: UInt8) -> String {
		SGR(38, 2, r, g, b)
	}
	
	/// `Select Graphic Rendition`: Sets colors and style of the characters following this code
	@inlinable public static func SGR(bgRGB r: UInt8, _ g: UInt8, _ b: UInt8) -> String {
		SGR(48, 2, r, g, b)
	}
	
	/// `Device Status Report`: Reports the cursor position
	///
	/// Report is done by transmitting `ESC[n;mR`, where `n` is the row and `m` is the column.
	public static let DSR = "\(CSI)6n"
	
	//TODO: DECDSR
	//TODO: DECSTR
	//TODO: DECSCUSR
	//TODO: DECSTBM
	//TODO: SCOSC
	//TODO: SCORC
	//TODO: DECIC
	//TODO: DECDC
	
}
