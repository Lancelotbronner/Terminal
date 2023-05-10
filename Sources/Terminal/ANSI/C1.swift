//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-25.
//

//MARK: - C1 Control Codes

extension LegacySequence {
	
	/// `Index`: Move the cursor one line down scrolling if needed
	public static let IND: Character = "\u{84}"
	
	/// `Next Line`: Move the cursor to the beginning of the next row
	public static let NEL: Character = "\u{85}"
	
	/// `Horizontal Tabulation Set`: Places a tab stop at the current cursor position
	public static let HTS: Character = "\u{88}"
	
	/// `Reverse Index`: Moves cursor up one line, maintains horizontal position, scrolling if needed
	public static let RI: Character = "\u{8D}"
	
	/// `Single Shift Select G2`: Selects the G2 character set for the next character
	public static let SS2 = "\u{8E}"
	
	/// `Single Shift Select G3`: Selects the G3 character set for the next character
	public static let SS3 = "\u{8F}"
	
	/// `Device Control String`: Start of a DCS sequence
	public static let DCS: Character = "\u{90}"
	
	/// `Control Sequence Introducer`: Start of a CSI sequence
	public static let CSI: Character = "\u{9B}"
	
	/// `String Terminator`: Terminator used for string type sequences
	public static let ST: Character = "\u{9D}"
	
	/// `Operating System Command`: Start of an OSC sequence
	public static let OSC: Character = "\u{9D}"
	
	/// `Privacy Message`: Start of a privacy message
	public static let PM: Character = "\u{9D}"
	
	/// `Application Program Command`: Start of an APC sequence
	public static let APC: Character = "\u{9F}"

	
}
