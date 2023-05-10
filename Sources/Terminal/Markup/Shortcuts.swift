//
//  File.swift
//
//
//  Created by Christophe Bronner on 2022-03-11.
//

//MARK: - String Styling

extension String {
	
	//MARK: Style
	
	@inlinable public func style(_ style: Style) -> String {
		apply(style.description)
	}
	
	@inlinable public func style(
		foreground: ForegroundColor = .inherited,
		background: BackgroundColor = .inherited,
		decorations: ConsoleDecoration = .inherited
	) -> String {
		style(Style(
			foreground: foreground,
			background: background,
			decoration: decorations
		))
	}
	
	@inlinable public func style(
		foreground: ForegroundColor = .inherited,
		background: BackgroundColor = .inherited,
		weight: ConsoleWeight = .inherited,
		underline: ConsoleUnderline = .inherited,
		italics: ConsoleItalics = .inherited,
		blink: ConsoleBlink = .inherited,
		inverse: ConsoleInverse = .inherited,
		visibility: ConsoleVisibility = .inherited,
		strikethrough: ConsoleStrikethrough = .inherited
	) -> String {
		style(
			foreground: foreground,
			background: background,
			decorations: ConsoleDecoration(
				weight: weight,
				underline: underline,
				italics: italics,
				blink: blink,
				inverse: inverse,
				visibility: visibility,
				strikethrough: strikethrough
			)
		)
	}

	//MARK: Foreground Colors

	@inlinable public func foreground(_ color: ForegroundColor) -> String {
		apply(color.description)
	}
	
	@inlinable public func foreground(extended code: UInt8) -> String {
		apply(ControlSequence.SGR(fg256: code))
	}
	
	@inlinable public func foreground(rgb r: UInt8, _ g: UInt8, _ b: UInt8) -> String {
		apply(ControlSequence.SGR(fgRGB: r, g, b))
	}

	@inlinable public var plain: String {
		begin(ControlSequence.SGR(bit8: 39))
	}

	@inlinable public var black: String {
		foreground(.black)
	}

	@inlinable public var red: String {
		foreground(.red)
	}

	@inlinable public var green: String {
		foreground(.green)
	}

	@inlinable public var yellow: String {
		foreground(.yellow)
	}

	@inlinable public var blue: String {
		foreground(.blue)
	}

	@inlinable public var magenta: String {
		foreground(.magenta)
	}

	@inlinable public var cyan: String {
		foreground(.cyan)
	}

	@inlinable public var white: String {
		foreground(.white)
	}

	@inlinable public var brightBlack: String {
		foreground(.brightBlack)
	}

	@inlinable public var brightRed: String {
		foreground(.brightRed)
	}

	@inlinable public var brightGreen: String {
		foreground(.brightGreen)
	}

	@inlinable public var brightYellow: String {
		foreground(.brightYellow)
	}

	@inlinable public var brightBlue: String {
		foreground(.brightBlue)
	}

	@inlinable public var brightMagenta: String {
		foreground(.brightMagenta)
	}

	@inlinable public var brightCyan: String {
		foreground(.brightCyan)
	}

	@inlinable public var brightWhite: String {
		foreground(.brightWhite)
	}

	//MARK: Background Colors

	@inlinable public func background(_ color: BackgroundColor) -> String {
		apply(color.description)
	}
	
	@inlinable public func background(extended code: UInt8) -> String {
		apply(ControlSequence.SGR(bg256: code))
	}

	@inlinable public func background(rgb r: UInt8, _ g: UInt8, _ b: UInt8) -> String {
		apply(ControlSequence.SGR(bgRGB: r, g, b))
	}

	@inlinable public var onPlain: String {
		begin(ControlSequence.SGR(bit8: 49))
	}

	@inlinable public var onBlack: String {
		background(.black)
	}

	@inlinable public var onRed: String {
		background(.red)
	}

	@inlinable public var onGreen: String {
		background(.green)
	}

	@inlinable public var onYellow: String {
		background(.yellow)
	}

	@inlinable public var onBlue: String {
		background(.blue)
	}

	@inlinable public var onMagenta: String {
		background(.magenta)
	}

	@inlinable public var onCyan: String {
		background(.cyan)
	}

	@inlinable public var onWhite: String {
		background(.white)
	}

	@inlinable public var onBrightBlack: String {
		background(.brightBlack)
	}

	@inlinable public var onBrightRed: String {
		background(.brightRed)
	}

	@inlinable public var onBrightGreen: String {
		background(.brightGreen)
	}

	@inlinable public var onBrightYellow: String {
		background(.brightYellow)
	}

	@inlinable public var onBrightBlue: String {
		background(.brightBlue)
	}

	@inlinable public var onBrightMagenta: String {
		background(.brightMagenta)
	}

	@inlinable public var onBrightCyan: String {
		background(.brightCyan)
	}

	@inlinable public var onBrightWhite: String {
		background(.brightWhite)
	}

	//MARK: Decoration

	@inlinable public func decoration(_ decoration: ConsoleDecoration) -> String {
		apply(decoration.description)
	}
	
	@inlinable public func weight(_ decoration: ConsoleWeight) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func underline(_ decoration: ConsoleUnderline) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func italics(_ decoration: ConsoleItalics) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func blink(_ decoration: ConsoleBlink) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func inverse(_ decoration: ConsoleInverse) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func visibility(_ decoration: ConsoleVisibility) -> String {
		decorate(decoration.code)
	}
	
	@inlinable public func strikethrough(_ decoration: ConsoleStrikethrough) -> String {
		decorate(decoration.code)
	}

	@inlinable public var bold: String {
		weight(.bold)
	}

	@inlinable public var dim: String {
		weight(.dim)
	}

	@inlinable public var italic: String {
		italics(.enabled)
	}

	@inlinable public var underline: String {
		underline(.single)
	}

	@inlinable public var blink: String {
		blink(.slow)
	}

	@inlinable public var inverse: String {
		inverse(.enabled)
	}

	@inlinable public var strikethrough: String {
		strikethrough(.enabled)
	}
	
	//MARK: Utilities
	
	@usableFromInline func decorate(_ code: UInt8?) -> String {
		if let code = code {
			return apply(ControlSequence.SGR(code))
		}
		return self
	}
	
	@usableFromInline func begin(_ sequence: String) -> String {
		"\(sequence)\(self)"
	}
	
	@usableFromInline func apply(_ sequence: String) -> String {
		"\(sequence)\(self)\(ControlSequence.SGR)"
	}

}
