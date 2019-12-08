
//MARK: - Generic Stack

@available(OSX 10.15.0, *)
fileprivate protocol AnyStack: Presentable, View {
    associatedtype Aligned: AnyAlignment
    
    var alignment: Aligned { get }
    var spacing: Int { get }
    var items: [Presentable] { get }
    
    init(_ a: Aligned, _ s: Int, _ cs: [Presentable])
    
    func dimension(_ r: Rect) -> Dimensions
    func position(_ sPos: Int, _ oPos: Int, _ sLen: Int, _ oLen: Int) -> Rect
    func query() -> Queries
}

@available(OSX 10.15.0, *)
extension AnyStack {
    
    //MARK: - Typealiases
    
    typealias Dimensions = (sPos: Int, oPos: Int, sLen: Int, oLen: Int)
    typealias Queries = (s: (Presentable) -> Length, o: (Presentable) -> Length)
    
    //MARK: - View
    
    private func getLengths(_ mp: (Presentable) -> Length) -> (ls: [Length], fl: [Length], fi: [Length]) {
        let lengths = items.map(mp)
        let (flexible, fixed) = lengths.separated
        return (lengths, flexible, fixed)
    }
    
    public func draw(in rect: Rect) {
        let dimensions = dimension(rect)
        let queries = query()
        
        let availableSpace = dimensions.sLen - spacing * (items.count - 1)
        let (lengths, flexibleItems, fixedItems) = getLengths(queries.s)
        let flexibleSpace = availableSpace - fixedItems.fixedSum
        let distribution = flexibleItems.isEmpty ? 0 : flexibleSpace / flexibleItems.count
        
        var pos = dimensions.sPos
        for i in 0 ..< items.count {
            let item = items[i]
            let rawLen = lengths[i]
            let oRawLen = queries.o(item)
            
            let sLen = rawLen.isInfinity ? distribution : rawLen.value
            let oLen = oRawLen.isInfinity ? dimensions.oLen : oRawLen.value
            
            var align = dimensions.oPos
            switch alignment {
            case Aligned.ordered[0]: align += 0
            case Aligned.ordered[1]: align += (dimensions.oLen - oLen) / 2
            case Aligned.ordered[2]: align += dimensions.oLen - oLen
            default: align = -1
            }
            
            let frame = position(pos, align, sLen, oLen)
            item.draw(in: frame)
            
            pos += sLen + spacing
        }
    }
    
}

//MARK: - HStack

@available(OSX 10.15.0, *)
public struct HStack: AnyStack {
    
    //MARK: - Properties
    
    public typealias Aligned = VerticalAlignment
    
    let alignment: VerticalAlignment
    let spacing: Int
    let items: [Presentable]
    
    //MARK: - Initialization
    
    fileprivate init(_ a: Aligned = .center, _ s: Int = 0, _ contents: [Presentable]) {
        items = contents
        alignment = a
        spacing = s
    }
    
    public init<V: View>(alignment a: Aligned = .center, spacing s: Int = 0, @ViewBuilder _ view: Built<V>) {
        self.init(a, s, view().asPresentables)
    }
    
    //MARK: - View
    
    public var queryHeight: Length { items.heights.max }
    public var queryWidth: Length { items.widths.max }
    
    fileprivate func dimension(_ r: Rect) -> Dimensions {
        (r.x, r.y, r.width, r.height)
    }
    
    fileprivate func position(_ sPos: Int, _ oPos: Int, _ sLen: Int, _ oLen: Int) -> Rect {
        Rect(sPos, oPos, sLen, oLen)
    }
    
    fileprivate func query() -> Queries {
        ({ $0.queryWidth }, { $0.queryHeight })
    }
    
}

//MARK: - VStack

@available(OSX 10.15.0, *)
public struct VStack: AnyStack {
    
    //MARK: - Properties
    
    public typealias Aligned = VerticalAlignment
    
    let alignment: VerticalAlignment
    let spacing: Int
    let items: [Presentable]
    
    //MARK: - Initialization
    
    fileprivate init(_ a: Aligned = .center, _ s: Int = 0, _ contents: [Presentable]) {
        items = contents
        alignment = a
        spacing = s
    }
    
    public init<V: View>(alignment a: Aligned = .center, spacing s: Int = 0, @ViewBuilder _ view: Built<V>) {
        self.init(a, s, view().asPresentables)
    }
    
    //MARK: - View
    
    public var queryHeight: Length { items.heights.max }
    public var queryWidth: Length { items.widths.max }
    
    fileprivate func dimension(_ r: Rect) -> Dimensions {
        (r.y, r.x, r.height, r.width)
    }
    
    fileprivate func position(_ sPos: Int, _ oPos: Int, _ sLen: Int, _ oLen: Int) -> Rect {
        Rect(oPos, sPos, oLen, sLen)
    }
    
    fileprivate func query() -> Queries {
        ({ $0.queryHeight }, { $0.queryWidth })
    }
    
}
