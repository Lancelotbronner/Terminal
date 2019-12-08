@available(OSX 10.15.0, *)
public struct Empty: Presentable, View {
    
    public init() { }
    
    var queryWidth: Length { 0 }
    var queryHeight: Length { 0 }
    
    func draw(in rect: Rect) { }
}
