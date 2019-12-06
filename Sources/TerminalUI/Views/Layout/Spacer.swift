public struct Spacer: Presentable {
    
    //MARK: - Properties
    
    let length: Length
    
    //MARK: - Initialization
    
    public init(length l: Length = .infinity) {
        length = l
    }
    
    //MARK: - View
    
    public var queryWidth: Length { length }
    public var queryHeight: Length { length }
    public func draw(in rect: Rect) { }
}
