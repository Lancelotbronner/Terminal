//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Controls

extension ControlSequence {
	
	/// `Save cursor`: Save cursor position, charmap and text attributes
	public static let SC = "\(ESC)7"
	
	/// `Restore cursor`: Restore cursor position, charmap and text attributes
	public static let RC = "\(ESC)8"
	
	//TODO: DECALN
	
	/// `Index`: Move the cursor one line down scrolling if needed
	public static let IND = "\(ESC)D"
	
	/// `Next Line`: Move the cursor to the beginning of the next row
	public static let NEL = "\(ESC)E"
	
	/// `Horizontal Tabulation Set`: Places a tab stop at the current cursor position
	public static let HTS = "\(ESC)H"
	
	/// `Reverse Index`: Move the cursor one line up scrolling if needed
	public static let IR = "\(ESC)H"

	/// `Device Control String`: Start of a DCS sequence
	public static let DCS = "\(ESC)P"
	
	/// `Control Sequence Introducer`: Start of a CSI sequence
	public static let CSI = "\(ESC)["
	
	//TODO: ST
	
	/// `Operating System Command`: Start of an OSC sequence
	public static let OSC = "\(ESC)]"
	
	//TODO: PM
	//TODO: APC
	
}
