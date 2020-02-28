
//MARK: - Argument

extension Command {
    public struct Argument {
        
        //MARK: - Properties
        
        private let raw: Substring
        
        //MARK: - Initialization
        
        init(_ s: Substring) {
            raw = s
        }
        
        //MARK: - Access
        
        public func string() -> String {
            String(raw)
        }
        
        public func integer() throws -> Int {
            guard let n = Int(raw) else { throw Errors.expectedInteger(string()) }
            return n
        }
        
        public func range(_ r: Range<Int>) throws -> Int {
            let n = try integer()
            guard r.contains(n) else { throw Errors.expectedIntegerInRange(r.lowerBound, r.upperBound, n)}
            return n
        }
        
        public func double() throws -> Double {
            guard let n = Double(raw) else { throw Errors.expectedDouble(string()) }
            return n
        }
        
        public func range(_ r: Range<Double>) throws -> Double {
            let n = try double()
            guard r.contains(n) else { throw Errors.expectedDoubleInRange(r.lowerBound, r.upperBound, n)}
            return n
        }
        
        public func bool() throws -> Bool {
            guard let n = Bool(String(raw)) else { throw Errors.expectedBool(string()) }
            return n
        }
        
    }
}
