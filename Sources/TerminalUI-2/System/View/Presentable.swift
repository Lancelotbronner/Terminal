
//MARK: - Protocol

protocol Presentable {
    var environement: Environement? { get set }
    var queryWidth: Length { get }
    var queryHeight: Length { get }
    
    func draw(in rect: Rect)
}
extension Presentable {
    
    public var body: some View { Empty() }
    var env: Environement { environement ?? .default }
    
    mutating func environement(_ env: Environement) -> Presentable {
        environement = env
        return self
    }
    
}

//MARK: - Array

extension Array where Element: Presentable {
    
    var queryWidths: [Length] { map { $0.queryWidth } }
    var queryHeights: [Length] { map { $0.queryHeight } }
    
}
