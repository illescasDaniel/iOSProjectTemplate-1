// Logger.swift
// by Daniel Illescas Romero
// Github: @illescasDaniel
// License: MIT

import class Foundation.NSString
import class Foundation.DateFormatter
import struct Foundation.Date
import class Foundation.Bundle
import os.log
import AppFolder

// See this for sysdiagnose logging instructions:
// https://download.developer.apple.com/iOS/iOS_Logs/sysdiagnose_Logging_Instructions.pdf
public final class Logger {
	
	public static var saveToFile: Bool = false
	private(set) static var currentFileName: String = ""
	private static let logsFolder = AppFolder.Documents.appending("Logs").url
	
	public static var currentLog: String {
		return Logger.logFile(current: true)
	}
	
	public static var lastLog: String {
		return Logger.logFile(current: false)
	}
	
	public static func log<T: CustomStringConvertible>(_ message: T, type: OSLogType = .default, category: Category = .app,
													   accessLevel: AccessLevel = .public, options: [Option] = Option.allCases,
													   filePath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		
		let extraInfo: String = Logger.extraInfo(from: options, filePath: filePath, functionName: functionName, lineNumber: lineNumber)
		
		switch accessLevel {
		case .public:
			os_log("[%{public}s][%{public}s] \n> %{public}s", log: category.osLog, type: type, extraInfo, type.description, message.description)
		case .private:
			os_log("[%{public}s][%{public}s] \n> %{private}s", log: category.osLog, type: type, extraInfo, type.description, message.description)
		}
		Logger.saveToFile(string: String(format: "[%@][%@] \n> %@", extraInfo, type.description, message.description))
	}
	
	private static func saveToFile(string: String) {
		DispatchQueue.global().async {
			guard saveToFile else { return }
			
			if self.currentFileName.isEmpty {
				self.currentFileName = "\(Date().timeIntervalSince1970).log"
			}
			
			if !FileManager.default.fileExists(atPath: Logger.logsFolder.path) {
				try? FileManager.default.createDirectory(at: Logger.logsFolder, withIntermediateDirectories: false)
			} else {
				Logger.removeOlderFiles()
			}
			
			if let data = "\(string)\n".data(using: .utf8) {
				let filePath = Logger.logsFolder.appendingPathComponent(self.currentFileName).path
				if !FileManager.default.fileExists(atPath: filePath) {
					FileManager.default.createFile(atPath: filePath, contents: data)
				} else if let fileHandle = FileHandle(forWritingAtPath: filePath) {
					fileHandle.seekToEndOfFile()
					fileHandle.write(data)
				}
			}
		}
	}
	
	// MARK: - Convenience
	
	private static var dateOptionInfo: String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatterGet.string(from: Date()).description
	}
	
	private static func extraInfo(from options: [Option], filePath: String, functionName: String, lineNumber: Int) -> String {
		
		var extraInfo: String = ""
		
		guard !options.isEmpty else { return "" }
		
		if options.contains(.date) {
			extraInfo += Logger.dateOptionInfo
		}
		
		if options.contains(.fileAndLine) {
			let fileAndLine = "\((filePath as NSString).lastPathComponent):\(lineNumber)"
			extraInfo = extraInfo.isEmpty ? fileAndLine : "\(extraInfo) - \(fileAndLine)"
		}
		
		if options.contains(.function) {
			extraInfo = extraInfo.isEmpty ? functionName : "\(extraInfo) \(functionName)"
		}
		
		return extraInfo
	}
	
	private static func logFile(current: Bool) -> String {
		if let logFiles = Logger.sortedLogFiles {
			
			var filePath = Logger.logsFolder.appendingPathComponent(self.currentFileName).path
			if !current, let path = logFiles.first(where: { $0.lastPathComponent != self.currentFileName })?.path {
				filePath = path
			}
			if let data = FileManager.default.contents(atPath: filePath) {
				return String(data: data, encoding: .utf8) ?? ""
			}
		}
		return ""
	}
	
	private static var sortedLogFiles: [URL]? {
		return (try? FileManager.default.contentsOfDirectory(at: Logger.logsFolder, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]))?.sorted(by: { lhs, rhs in lhs.lastPathComponent >= rhs.lastPathComponent })
	}
	
	private static func removeOlderFiles() {
		let allFiles = Logger.sortedLogFiles
		if (allFiles ?? []).count > 10 {
			allFiles?.dropFirst().forEach {
				try? FileManager.default.removeItem(at: $0)
			}
		}
	}
}

extension OSLogType: CustomStringConvertible {
	public var description: String {
		switch self {
		case OSLogType.debug:
			return "debug"
		case OSLogType.default:
			return "default"
		case OSLogType.error:
			return "error"
		case OSLogType.fault:
			return "fault"
		case OSLogType.info:
			return "info"
		default: return "?"
		}
	}
}

// MARK: - Details

public extension Logger {
	public enum Category {
		case app
		case ui
		case network
		case db
		case business
		case custom(osLog: OSLog)
		case category(_ category: String)
	}
	
	public enum AccessLevel {
		case `public`
		case `private`
	}
	
	public enum Option: CaseIterable {
		case date
		case fileAndLine
		case function
	}
}

public extension Logger.Category {
	var osLog: OSLog {
		let defaultSubsystem = Bundle.main.bundleIdentifier ?? "?"
		switch self {
		case .custom(let osLog):
			return osLog
		case .category(let category):
			return OSLog(subsystem: defaultSubsystem, category: category)
		default:
			return OSLog(subsystem: defaultSubsystem, category: "\(self)")
		}
	}
}
