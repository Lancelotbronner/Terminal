//
//  File.swift
//  
//
//  Created by Christophe Bronner on 10/06/2020.
//

extension String {
    
    //MARK: Reset
    
    @inline(__always)
    public func normal() -> String {
        wrap(inactive: Constants.RESET_ALL)
    }
    
    //MARK: Weight
    
    public func weight(_ weight: Style.Weight) -> String {
        switch weight {
        case .bold: return bold()
        case .dim: return dim()
        }
    }
    
    @inline(__always)
    public func bold(_ active: Bool = true) -> String {
        wrap(Constants.BOLD, Constants.RESET_BOLD, active)
    }
    
    @inline(__always)
    public func dim(_ active: Bool = true) -> String {
        wrap(Constants.DIM, Constants.RESET_DIM, active)
    }
    
    //MARK: Style
    
    @inline(__always)
    public func italic(_ active: Bool = true) -> String {
        wrap(Constants.ITALIC, Constants.RESET_ITALIC, active)
    }
    
    @inline(__always)
    public func underline(_ active: Bool = true) -> String {
        wrap(Constants.UNDERLINE, Constants.RESET_UNDERLINE, active)
    }
    
    //MARK: Special
    
    @inline(__always)
    public func blink(_ active: Bool = true) -> String {
        wrap(Constants.BLINK, Constants.RESET_BLINK, active)
    }
    
    @inline(__always)
    public func reverse(_ active: Bool = true) -> String {
        wrap(Constants.REVERSE, Constants.RESET_REVERSE, active)
    }
    
    @inline(__always)
    public func hidden(_ active: Bool = true) -> String {
        wrap(Constants.HIDDEN, Constants.RESET_HIDDEN, active)
    }
    
    //MARK: Foreground
    
    public func foreground(_ color: Color) -> String {
        switch color {
        case .normal: return normalForeground()
        case .black: return blackForeground()
        case .red: return redForeground()
        case .green: return greenForeground()
        case .yellow: return yellowForeground()
        case .blue: return blueForeground()
        case .magenta: return magentaForeground()
        case .cyan: return cyanForeground()
        case .white: return whiteForeground()
        case .lightBlack: return lightBlackForeground()
        case .lightRed: return lightRedForeground()
        case .lightGreen: return lightGreenForeground()
        case .lightYellow: return lightYellowForeground()
        case .lightBlue: return lightBlueForeground()
        case .lightMagenta: return lightMagentaForeground()
        case .lightCyan: return lightCyanForeground()
        case .lightWhite: return lightWhiteForeground()
        }
    }
    
    @inline(__always)
    public func normalForeground() -> String {
        wrap(inactive: Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func blackForeground() -> String {
        wrap(active: Constants.FOREGROUND_BLACK, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func redForeground() -> String {
        wrap(active: Constants.FOREGROUND_RED, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func greenForeground() -> String {
        wrap(active: Constants.FOREGROUND_GREEN, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func yellowForeground() -> String {
        wrap(active: Constants.FOREGROUND_YELLOW, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func blueForeground() -> String {
        wrap(active: Constants.FOREGROUND_BLUE, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func magentaForeground() -> String {
        wrap(active: Constants.FOREGROUND_MAGENTA, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func cyanForeground() -> String {
        wrap(active: Constants.FOREGROUND_CYAN, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func whiteForeground() -> String {
        wrap(active: Constants.FOREGROUND_WHITE, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightBlackForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_BLACK, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightRedForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_RED, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightGreenForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_GREEN, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightYellowForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_YELLOW, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightBlueForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_BLUE, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightMagentaForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_MAGENTA, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightCyanForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_CYAN, Constants.RESET_FOREGROUND)
    }
    
    @inline(__always)
    public func lightWhiteForeground() -> String {
        wrap(active: Constants.FOREGROUND_LIGHT_WHITE, Constants.RESET_FOREGROUND)
    }
    
    //MARK: Background
    
    public func background(_ color: Color) -> String {
        guard Terminal.isStyleEnabled else { return self }
        switch color {
        case .normal: return normalBackground()
        case .black: return blackBackground()
        case .red: return redBackground()
        case .green: return greenBackground()
        case .yellow: return yellowBackground()
        case .blue: return blueBackground()
        case .magenta: return magentaBackground()
        case .cyan: return cyanBackground()
        case .white: return whiteBackground()
        case .lightBlack: return lightBlackBackground()
        case .lightRed: return lightRedBackground()
        case .lightGreen: return lightGreenBackground()
        case .lightYellow: return lightYellowBackground()
        case .lightBlue: return lightBlueBackground()
        case .lightMagenta: return lightMagentaBackground()
        case .lightCyan: return lightCyanBackground()
        case .lightWhite: return lightWhiteBackground()
        }
    }
    
    @inline(__always)
    public func normalBackground() -> String {
        wrap(inactive: Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func blackBackground() -> String {
        wrap(active: Constants.BACKGROUND_BLACK, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func redBackground() -> String {
        wrap(active: Constants.BACKGROUND_RED, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func greenBackground() -> String {
        wrap(active: Constants.BACKGROUND_GREEN, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func yellowBackground() -> String {
        wrap(active: Constants.BACKGROUND_YELLOW, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func blueBackground() -> String {
        wrap(active: Constants.BACKGROUND_BLUE, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func magentaBackground() -> String {
        wrap(active: Constants.BACKGROUND_MAGENTA, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func cyanBackground() -> String {
        wrap(active: Constants.BACKGROUND_CYAN, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func whiteBackground() -> String {
        wrap(active: Constants.BACKGROUND_WHITE, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightBlackBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_BLACK, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightRedBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_RED, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightGreenBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_GREEN, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightYellowBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_YELLOW, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightBlueBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_BLUE, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightMagentaBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_MAGENTA, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightCyanBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_CYAN, Constants.RESET_BACKGROUND)
    }
    
    @inline(__always)
    public func lightWhiteBackground() -> String {
        wrap(active: Constants.BACKGROUND_LIGHT_WHITE, Constants.RESET_BACKGROUND)
    }
    
    //MARK: Utilities
    
    private func wrap(active set: Int, _ reset: Int) -> String {
        guard Terminal.isStyleEnabled else { return self }
        return Sequence.make(.csi, set.description, .textStyle) + self + Sequence.make(.csi, reset.description, .textStyle)
    }
    
    private func wrap(inactive reset: Int) -> String {
        guard Terminal.isStyleEnabled else { return self }
        return Sequence.make(.csi, reset.description, .textStyle) + self
    }
    
    private func wrap(_ set: Int, _ reset: Int, _ active: Bool) -> String {
        guard Terminal.isStyleEnabled else { return self }
        return active ? wrap(active: set, reset) : wrap(inactive: reset)
    }
    
}
