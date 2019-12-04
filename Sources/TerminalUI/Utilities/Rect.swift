public struct Rect {
    
    //MARK: - Properties
    
    var x = 1
    var y = 1
    var width = 0
    var height = 0
    
    public var rangeX: ClosedRange<Int> { x ... (x + width - 1) }
    public var rangeY: ClosedRange<Int> { y ... (y + height - 1) }
    
    //MARK: - Initialization
    
    init() { }
    
    public init(_ x: Int, _ y: Int, _ w: Int, _ h: Int) {
        self.x = x
        self.y = y
        width = w
        height = h
    }
    
    public init(_ w: Int, _ h: Int) {
        self.init(1, 1, w, h)
    }
    
}
