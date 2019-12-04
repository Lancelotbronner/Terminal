
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
    
    static let topLeading = Alignment(.leading, .top)
    static let centerLeading = Alignment(.leading, .center)
    static let bottomLeading = Alignment(.leading, .bottom)
    static let topCenter = Alignment(.center, .top)
    static let center = Alignment(.center, .center)
    static let bottomCenter = Alignment(.center, .bottom)
    static let topTrailing = Alignment(.trailing, .top)
    static let centerTrailing = Alignment(.trailing, .center)
    static let bottomTrailing = Alignment(.trailing, .bottom)
    
}
