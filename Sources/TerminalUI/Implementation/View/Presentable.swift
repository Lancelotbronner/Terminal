import Terminal

//MARK: - View

@available(OSX 10.15.0, *)
protocol Presentable {
    func draw(in rect: Rect)
    
    var queryWidth: Length { get }
    var queryHeight: Length { get }
}

@available(OSX 10.15.0, *)
extension Presentable {
    
    public func background(_ v: Presentable, clipToBounds: Bool = true) -> Presentable {
        ZStack(v, self)
            .frame(width: clipToBounds ? queryWidth : nil, height: clipToBounds ? queryHeight : nil)
    }
    
    public func overlay(_ v: Presentable, clipToBounds: Bool = true) -> Presentable {
        ZStack(self, v)
            .frame(width: clipToBounds ? queryWidth : nil, height: clipToBounds ? queryHeight : nil)
    }
    
    public func frame(width: Length? = nil, height: Length? = nil) -> Presentable {
        Frame(self, width, height)
    }
    
    public func padding(_ length: Int, _ edges: Edges = .all) -> Presentable {
        Padding(self, edges, length)
    }
    
    public func border(_ width: Int, char: Character? = nil, foreground: Foreground? = nil, background: Background? = nil, style: Style? = nil) -> Presentable {
        Border(self, width, char, foreground, background, style)
    }
    
}

//MARK: - Collections

@available(OSX 10.15.0, *)
extension Array where Element == Presentable {
    
    var widths: [Length] { map { $0.queryWidth } }
    var heights: [Length] { map { $0.queryHeight } }
    
}
