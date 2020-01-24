import Terminal

//MARK: - Environement

final class Environement {
    
    static let `default` = Environement()
    
    public private(set) var color = Foreground.default
    public private(set) var background = Background.default
    public private(set) var style = Style.default
    
}
