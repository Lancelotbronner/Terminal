public struct Length {
    
    //MARK: - Constants
    
    public static let infinity = Length(value: nil)
    
    //MARK: - Properties
    
    private var _value: Int?
    
    var value: Int { _value == nil ? Int.max : _value! }
    var isInfinity: Bool { _value == nil }
    
    //MARK: - Initialization
    
    private init(value: Int?) {
        _value = value
    }
    
    public init(_ v: Int) {
        _value = v
    }
    
}

//MARK: - Literal

extension Length: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: value)
    }
}

//MARK: - Math

extension Length: AdditiveArithmetic {
    
    static prefix func -(rhs: Length) -> Length {
        guard !rhs.isInfinity else { return 0 }
        return Length(-rhs.value)
    }
    
    public static func +(lhs: Length, rhs: Length) -> Length {
        guard !(lhs.isInfinity || rhs.isInfinity) else { return .infinity }
        return Length(value: lhs.value + rhs.value)
    }
    
    public static func -(lhs: Length, rhs: Length) -> Length {
        lhs + -rhs
    }
    
    public static func +=(lhs: inout Length, rhs: Length) {
        lhs = lhs + rhs
    }
    
    public static func -=(lhs: inout Length, rhs: Length) {
        lhs = lhs - rhs
    }
    
    public static func *(lhs: Length, rhs: Length) -> Length {
        guard !(lhs.isInfinity || rhs.isInfinity) else { return .infinity }
        return Length(value: lhs.value * rhs.value)
    }
    
}

//MARK: - Logic

extension Length: Equatable, Comparable {
    
    public static func <(lhs: Length, rhs: Length) -> Bool {
        switch true {
        case lhs.isInfinity: return false
        case rhs.isInfinity: return true
        default: return lhs.value < rhs.value
        }
    }
    
}

//MARK: - Conversion

extension Int {
    var toLength: Length { .init(self) }
}

extension Length {
    var toInt: Int { value }
}
