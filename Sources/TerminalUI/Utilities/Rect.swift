public struct Rect {
    
    //MARK: - Properties
    
    var x = 0
    var y = 0
    var width = 0
    var height = 0
    
    public var rangeX: ClosedRange<Int> { x ... (x + width) }
    public var rangeY: ClosedRange<Int> { y ... (y + height) }
    
    //MARK: - Initialization
    
    init() { }
    
    public init(_ x: Int, _ y: Int, _ w: Int, _ h: Int) {
        self.x = x
        self.y = y
        width = w
        height = h
    }
    
    public init(_ w: Int, _ h: Int) {
        self.init(0, 0, w, h)
    }
    
}
