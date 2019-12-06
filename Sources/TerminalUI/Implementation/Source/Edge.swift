public enum Edge {
    case leading, trailing, top, bottom
}

public struct Edges {
    
    //MARK: - Properties
    
    private var elements: Set<Edge> = []
    
    var hasLeading: Bool { elements.contains(.leading) }
    var hasTrailing: Bool { elements.contains(.leading) }
    var hasBottom: Bool { elements.contains(.bottom) }
    var hasTop: Bool { elements.contains(.top) }
    var countH: Int { (hasLeading ? 1 : 0) + (hasTrailing ? 1 : 0) }
    var countV: Int { (hasBottom ? 1 : 0) + (hasTop ? 1 : 0) }
    
    //MARK: - Initialization
    
    public static let leading = Edges(.leading)
    public static let trailing = Edges(.trailing)
    public static let bottom = Edges(.bottom)
    public static let top = Edges(.top)
    public static let horizontal = Edges(.leading, .trailing)
    public static let vertical = Edges(.bottom, .top)
    public static let all = Edges(.leading, .trailing, .bottom, .top)
    
    init(_ edges: Edge...) {
        elements = Set(edges)
    }
    
    //MARK: - Methods
    
}
