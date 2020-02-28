
//MARK: - Errors

extension Command {
    public enum Errors: Error {
        
        //MARK: Argument Count Errors
        
        /// A call received arguments but expected none
        case expectedNoArguments
        
        /// A call expected an argument but there were none
        case expectedArgument
        
        /// A call did not get the right number of arguments
        case expectedArguments(_ expect: Int, _ got: Int)
        
        /// A call did not get the minimum number of arguments
        case expectedMinimumArguments(_ expectAtLeast: Int, _ got: Int)
        
        //MARK: Argument Type Errors
        
        case expectedInteger(_ got: String)
        
        case expectedIntegerInRange(_ lower: Int, _ upper: Int, _ got: Int)
        
        case expectedDouble(_ got: String)
        
        case expectedDoubleInRange(_ lower: Double, _ upper: Double, _ got: Double)
        
        case expectedBool(_ got: String)
        
    }
}
