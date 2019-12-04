
//MARK: - Alignments

public enum HorizontalAlignment {
    case leading, center, trailing
}

public enum VerticalAlignment {
    case top, center, bottom
}

//MARK: - Generic Alignment

public struct Alignment {
    
    var horizontal: HorizontalAlignment
    var vertical: VerticalAlignment
    
    public init(_ h: HorizontalAlignment, _ v: VerticalAlignment) {
        horizontal = h
        vertical = v
    }
    
    public static let topLeading = Alignment(.leading, .top)
    public static let centerLeading = Alignment(.leading, .center)
    public static let bottomLeading = Alignment(.leading, .bottom)
    public static let topCenter = Alignment(.center, .top)
    public static let center = Alignment(.center, .center)
    public static let bottomCenter = Alignment(.center, .bottom)
    public static let topTrailing = Alignment(.trailing, .top)
    public static let centerTrailing = Alignment(.trailing, .center)
    public static let bottomTrailing = Alignment(.trailing, .bottom)
    
}
