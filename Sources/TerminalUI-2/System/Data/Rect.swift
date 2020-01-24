
//MARK: - Rect

public struct Rect {
    
    //MARK: - Properties
    
    var origin: Point
    var size: Point
    
    public var width: Int { size.x }
    public var height: Int { size.y }
    
    public var leftX: Int { origin.x }
    public var centerX: Int { origin.x + size.x / 2 }
    public var rightX: Int { origin.x + size.x }
    
    public var bottomY: Int { origin.y }
    public var centerY: Int { origin.y + size.y / 2 }
    public var topY: Int { origin.y + size.y }
    
    public var horizontal: Range<Int> { origin.x ..< rightX }
    public var vertical: Range<Int> { origin.y ..< topY }
    
    //MARK: - Initialization
    
    static let zero = Rect(0, 0)
    static let one = Rect(1, 1, 1, 1)
    
    public init(_ origin: Point, _ size: Point) {
        self.origin = origin
        self.size = size
    }
    
    public init(_ x: Int, _ y: Int, _ w: Int, _ h: Int) {
        self.init(Point(x, y), Point(w < 0 ? 0 : w, h < 0 ? 0 : h))
    }
    
    public init(_ w: Int, _ h: Int) {
        self.init(0, 0, w, h)
    }
    
    
}
