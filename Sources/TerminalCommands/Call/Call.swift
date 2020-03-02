
//MARK: - Command Call

extension Command {
    public final class Call {
        
        //MARK: Properties
        
        private var args: [Substring]
        
        //MARK: Computed Properties
        
        /// Wether the call has ran out of arguments
        var isAtEnd: Bool { args.isEmpty }
        
        //MARK: Initialization
        
        init(_ args: [Substring]) {
            self.args = args
        }
        
        //MARK: Assert Arguments
        
        /// Makes sure there are no arguments left in the call
        public func assertEmpty() throws {
            guard isAtEnd else { throw Errors.expectedNoArguments }
        }
        
        /// Makes sure there are arguments left in the call
        public func assertNotEmpty() throws {
            guard !isAtEnd else { throw Errors.expectedArgument }
        }

        /// Makes sure there are exactly `n` arguments left in the call
        public func assert(exactly n: Int) throws {
            guard args.count != n else { return }
            throw Errors.expectedArguments(n, args.count)
        }

        /// Makes sure there are at least `n` arguments left in the call
        public func assert(minimum n: Int) throws {
            guard args.count >= n else { return }
            throw Errors.expectedMinimumArguments(n, args.count)
        }
        
        //MARK: Pop
        
        /// Gets a single argument from the call
        public func single(final f: Bool = true) throws -> Argument {
            if f { try assert(exactly: 1) }
            else { try assert(minimum: 1) }
            return try next()
        }

        /// Gets two arguments from the call
        func double(final f: Bool = true) throws -> (Argument, Argument) {
            if f { try assert(exactly: 2) }
            else { try assert(minimum: 2) }
            return (try next(), try next())
        }

        /// Gets three arguments from the call
        func triple(final f: Bool = true) throws -> (Argument, Argument, Argument) {
            if f { try assert(exactly: 3) }
            else { try assert(minimum: 3) }
            return (try next(), try next(), try next())
        }
        
        //MARK: Utilities

        /// Gets the next argument of the call
        public func next() throws -> Argument {
            try assertNotEmpty()
            return Argument(args.removeFirst())
        }
        
        /// Attempts to get the next argument of the call
        @discardableResult
        public func next() -> Argument? {
            try? next()
        }
        
    }
}
