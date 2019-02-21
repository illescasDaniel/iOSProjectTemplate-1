//
//  UserDefaultsManager.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 21/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public final class UserDefaultsManager {
	
	public static let standard = UserDefaultsManager()
	
	private init() {}
	
	public subscript<T>(dynamicMember member: String) -> T? {
		get {
			return try? self.object(forKey: member) as T
		} set {
			try? self.set(value: newValue, forKey: member)
		}
	}
	
	public func object<T>(forKey key: String) throws -> T {
		if let retrievedValue = UserDefaults.standard.object(forKey: key) {
			if let value = retrievedValue as? T {
				return value
			} else {
				Logger.log(L10n.Errors.UserDefaultsManager.Retrieve.couldNotCast("\(retrievedValue)", "\(T.self)"), type: .error)
				throw Errors.RetrieveError.couldNotCast(value: retrievedValue, type: "\(T.self)")
			}
		} else {
			Logger.log(L10n.Errors.UserDefaultsManager.Retrieve.keyNotFound(key), type: .error)
			throw Errors.RetrieveError.keyNotFound(key)
		}
	}
	
	public func set<T>(value: T, forKey key: String) throws {
		if self.isPropertyListObject(value) {
			UserDefaults.standard.set(value, forKey: key)
		} else {
			Logger.log(L10n.Errors.UserDefaultsManager.Set.notAPropertyListObject("\(T.self)"), type: .error)
			throw Errors.SetError.notAPropertyListObject(type: "\(T.self)")
		}
	}
	
	public func load<T>(defaultValue: T, forKey key: String) {
		do {
			let _: T = try self.object(forKey: key)
		} catch Errors.RetrieveError.keyNotFound(_) {
			self[dynamicMember: key] = defaultValue
		} catch { }
	}
	
	public func load(defaults dictionary: [String: Any]) {
		for (key, value) in dictionary {
			self.load(defaultValue: value, forKey: key)
		}
	}
	
	// Convenience
	
	private func isPropertyListObject<T>(_ object: T) -> Bool {
		switch object {
		case is NSData, is NSString, is NSNumber, is NSDate, is NSArray, is NSDictionary:
			return true
		default:
			return false
		}
	}
}

public extension UserDefaultsManager {
	public enum Errors {
		public enum SetError: Error {
			case notAPropertyListObject(type: String)
		}
		public enum RetrieveError: Error {
			case keyNotFound(_: String)
			case couldNotCast(value: Any, type: String)
		}
	}
}
