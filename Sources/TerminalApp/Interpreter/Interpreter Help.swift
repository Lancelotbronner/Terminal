//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal

//MARK: - Interpreter Help Generation

extension Interpreter {
	
	//MARK: Main
	
	internal func generateHelp() -> Command {
		var tmp = Command("help", description: "Displays information about the available commands")
		tmp += usageList()
//		tmp += usageCommand()
		return tmp
	}
	
	//MARK: Uses
	
	private func usageList() -> Usage {
		Usage("Displays all available commands") {
			// Calculate the maximum width of command keywords
			let width = groups
				.map { group in
					group.commands.map { cmd in
						cmd.keyword.count
					}.max() ?? 0
				}.max() ?? 0
			
			Output.leftmost()
			Output.writeln()
			
			Output.right()
			">   Help   <"
				.foreground(.blue)
				.bold()
				.outputln()
			Output.writeln()
			
			if let group = defaultGroup {
				displayContent(group, commandSummaryWidth: width)
			}
			for group in namedGroups {
				displayTitle(group)
				Output.writeln()
				displayContent(group, commandSummaryWidth: width)
			}
			
			Output.left()
		}
	}
	
	private func usageCommand() -> Usage {
		.init("", action: {})
	}
	
	//MARK: Descriptions
	
	private func describeCommandSummary(_ cmd: Command, width: Int? = nil) -> String {
		let w = width ?? cmd.keyword.count
		return ("\(cmd.keyword.pad(right: w))".bold()
			+ "    "
			+ (cmd.summary?.italic() ?? ""))
	}
	
	private func describeCommandAlternates(_ cmd: Command) -> String? {
		guard !cmd.alternateKeywords.isEmpty else { return nil }
		return cmd.alternateKeywords
			.map { $0.bold() }
			.joined(separator: ", ")
			.prefixed(with: "alternative: ")
	}
	
	private func describeArgument(_ arg: Argument) -> String {
		switch true {
		case arg.isVariadic:
			return "\(arg.type)"
				.suffixed(with: "...")
				.prefixed(with: arg.name?
							.suffixed(with: ":"))
			
		case arg.isOptional:
			return "\(arg.type)"
				.prefixed(with: arg.name?
							.suffixed(with: ":"))
				.prefixed(with: "[")
				.suffixed(with: "]")
			
		default:
			return "\(arg.type)"
				.prefixed(with: arg.name?
							.suffixed(with: ":"))
		}
	}
	
	private func describeUsageArguments(_ usage: Usage) -> String {
		usage.arguments
			.map(describeArgument)
			.joined(separator: ", ")
	}
	
	private func describeUsageSummary(_ usage: Usage, width: Int? = nil, arguments: String? = nil) -> String {
		let tmp = arguments ?? describeUsageArguments(usage)
		return tmp
			.pad(right: width ?? tmp.count)
			.suffixed(with: usage.summary?.prefixed(with: "    "))
	}
	
	//MARK: Display
	
	private func displayCommand(_ command: Command, summaryWidth: Int? = nil) {
		describeCommandSummary(command, width: summaryWidth)
			.outputln()
		
		Output.right()
		defer { Output.left() }
		
		describeCommandAlternates(command)?
			.outputln()

		if command.uses.count == 1 {
			guard !command.uses[0].arguments.isEmpty else { return }
			describeUsageArguments(command.uses[0]).prefixed(with: "Usage: ")
				.outputln()
			
		} else {
			let args = command.uses
				.map(describeUsageArguments)
			let width = args
				.map(\.count)
				.max() ?? 0
			zip(args, command.uses)
				.map { describeUsageSummary($1, width: width, arguments: $0) }
				.forEach { $0.outputln() }
		}
	}
	
	private func displayTitle(_ group: Group) {
		"[ \(group.name) ]"
			.foreground(.blue)
			.bold()
			.outputln()
	}
	
	private func displayContent(_ group: Group, commandSummaryWidth width: Int? = nil) {
		for cmd in group.commands {
			displayCommand(cmd)
			Output.writeln()
		}
	}
	
}
