
//MARK: - Protocol

protocol AnyAlignment: Equatable {
    static var ordered: [Self] { get }
}

//MARK: - Alignments

public enum HorizontalAlignment: AnyAlignment {
    case leading, center, trailing
    
    static let ordered: [HorizontalAlignment] = [.leading, .center, .trailing]
}

public enum VerticalAlignment: AnyAlignment {
    case top, center, bottom
    
    static let ordered: [VerticalAlignment] = [.top, .center, .bottom]
}

public struct Alignment {
    
    var horizontal: HorizontalAlignment
    var vertical: VerticalAlignment
    
    public init(_ h: HorizontalAlignment, _ v: VerticalAlignment) {
        horizontal = h
        vertical = v
    }
    
    public static let topLeft = Alignment(.leading, .top)
    public static let left = Alignment(.leading, .center)
    public static let bottomLeft = Alignment(.leading, .bottom)
    public static let top = Alignment(.center, .top)
    public static let center = Alignment(.center, .center)
    public static let bottom = Alignment(.center, .bottom)
    public static let topRight = Alignment(.trailing, .top)
    public static let right = Alignment(.trailing, .center)
    public static let bottomRight = Alignment(.trailing, .bottom)
    
}
