//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal

//MARK: - Configuration

extension Interpreter {
	public struct Configuration {
		
		//MARK: Typealiases
		
		public typealias NoCommandsFoundHandler = (_ keyword: String) -> Void
		public typealias WrongUsageHandler = (_ command: Command) -> Void
		
		//MARK: Properties
		
		private var _parser: () -> CommandParser
		private var _noCommandsFound: NoCommandsFoundHandler
		private var _wrongUsage: WrongUsageHandler
		
		//MARK: Computed Properties
		
		public var parser: CommandParser { _parser() }
		
		//MARK: Initialization
		
		public init() {
			_parser = { Parsers.default }
			
			_noCommandsFound = {
				("Command '"
					+ $0.foreground(.default).bold()
					+ "' does not exist, try '"
					+ "help".foreground(.default).bold()
					+ "' for a list of available commands")
					.foreground(.red)
					.outputln()
			}
			
			_wrongUsage = {
				print("Usage: \($0.uses)")
			}
		}
		
		//MARK: Setters
		
		public mutating func set(parser to: @autoclosure @escaping () -> CommandParser) {
			_parser = to
		}
		
		public mutating func onNoCommandsFound(_ handler: @escaping NoCommandsFoundHandler) {
			_noCommandsFound = handler
		}
		
		public mutating func onWrongUsage(_ handler: @escaping WrongUsageHandler) {
			_wrongUsage = handler
		}
		
		//MARK: Methods
		
		internal func handleNoCommandsFound(keyword: String) {
			_noCommandsFound(keyword)
		}
		
		internal func handleWrongUsage(command: Command) {
			_wrongUsage(command)
		}
		
	}
}
