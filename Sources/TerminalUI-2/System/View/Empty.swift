
public struct Empty: Presentable, View {
    
    public init() { }
    
    var queryWidth: Length { 0 }
    var queryHeight: Length { 0 }
    var environement: Environement?
    
    func draw(in rect: Rect) { }
}
