//
//  Json.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 19/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public final class Json {
	
	private var parent: (String, Json)?
	private var jsonObject: Any
	
	public static var null: Json {
		return Json()
	}
	
	// MARK: - Initializers
	
	fileprivate init(value: Any? = NSDictionary()) {
		self.jsonObject = value ?? NSDictionary()
	}
	
	public convenience init(data: Data) {
		let decodedJson = try? JSONSerialization.jsonObject(with: data, options: [])
		self.init(value: decodedJson)
	}
	
	public convenience init<T>(_ object: T?, parent: (String, Json)? = nil) {
		if object is Json, let json = object as? Json {
			self.init(json.jsonObject)
		} else if object is Data, let data = object as? Data {
			self.init(data: data)
		} else if let object = object, JSONSerialization.isValidJSONObject(object),
			let jsonData = try? JSONSerialization.data(withJSONObject: object) {
			self.init(data: jsonData)
		} else {
			self.init(value: object)
		}
		self.parent = parent
	}
	
	public convenience init<T: Encodable>(_ encodableObject: T) {
		if let encodedObject = try? JSONEncoder().encode(encodableObject) {
			self.init(data: encodedObject)
		} else {
			self.init()
		}
	}
	
	public convenience init(raw rawJson: String) {
		if let jsonData = rawJson.data(using: .utf8) {
			self.init(data: jsonData)
		} else {
			self.init(value: rawJson)
		}
	}
	
	// MARK: - Subscripts
	
	public subscript(dynamicMember member: String) -> Json {
		get {
			if let dictionary = self.jsonObject as? [String: Any] {
				let value = dictionary[member]
				if value == nil {
					Logger.log(L10n.Errors.Json.memberNotFound(member), type: .error)
				}
				return Json(value, parent: (member, self))
			}
			
			return Json(self.jsonObject, parent: (member, self))
		}
		set {
			if var dictionary = self.jsonObject as? [String: Any] {
				dictionary[member] = newValue.jsonObject
				self.jsonObject = dictionary
			} else {
				self.jsonObject = [member: newValue.jsonObject]
			}
			if let (key, json) = self.parent {
				json[dynamicMember: key] = Json(self.jsonObject)
			}
			
		}
	}
	
	public subscript(dynamicMember member: String) -> Any {
		get {
			return self[dynamicMember: member] as Json
		} set {
			if newValue is Json {
				self[dynamicMember: member] = newValue
			} else {
				self[dynamicMember: member] = Json(newValue)
			}
		}
	}
	
	public subscript(_ index: Int) -> Json {
		get {
			if let jsonArray = self.jsonObject as? [Any] {
				let value = jsonArray[index]
				return Json(value)
			}
			Logger.log(L10n.Errors.Json.valueIsNotAnArray("\(self.jsonObject)".truncated(limit: 100)), type: .error)
			return Json.null
		}
		set {
			if var jsonArray = self.jsonObject as? [Any] {
				jsonArray[index] = newValue.jsonObject
				self.jsonObject = jsonArray
			}
			if let (key, json) = self.parent {
				json[dynamicMember: key] = Json(self.jsonObject)
			}
		}
	}
	
	public subscript(_ index: Int) -> Any {
		get {
			return self[index] as Json
		} set {
			self[index] = Json(newValue)
		}
	}
	
	/// Use with **caution**, since an invalid keypath produces an uncatchable exception (in swift)
	public subscript(_ keyPath: KeyPath<Json.MemberStub, Json.MemberStub>) -> Json {
		let member = MemberStub()
		let key = member[keyPath: keyPath].key
		if let value: Any? = self[key] {
			return Json(value)
		}
		return Json.null
	}
	
	/// Use with **caution**, since an invalid keypath produces an uncatchable exception (in swift)
	public subscript<T>(_ keyPath: String) -> T? {
		return self.nsdictionary?.value(forKeyPath: keyPath) as? T
	}
	
	// MARK: - Codable
	
	public func decoded<T: Decodable>() -> T? {
		if let jsonData = self.encoded() {
			return try? JSONDecoder().decode(T.self, from: jsonData)
		}
		return nil
	}
	
	public func encoded() -> Data? {
		if JSONSerialization.isValidJSONObject(self.jsonObject), let jsonData = try? JSONSerialization.data(withJSONObject: self.jsonObject, options: .prettyPrinted) {
			return jsonData
		}
		return nil
	}
	
	// MARK: -
	
	public var string: String? {
		return self.jsonObject as? String
	}
	public var int: Int? {
		return self.jsonObject as? Int
	}
	public var bool: Bool? {
		return self.jsonObject as? Bool
	}
	public var double: Double? {
		return self.jsonObject as? Double
	}
	public var array: [Any]? {
		return self.jsonObject as? [Any]
	}
	public var dictionary: [String: Any]? {
		return self.jsonObject as? [String: Any]
	}
	public var nsdictionary: NSDictionary? {
		return self.jsonObject as? NSDictionary
	}
	public var any: Any {
		return self.jsonObject
	}
	
	//
	
	public var isJsonEmpty: Bool {
		return self.dictionary?.isEmpty == true
	}
}

extension Json: CustomStringConvertible {
	public var description: String {
		if let encodedJson = self.encoded(), let jsonString = String(data: encodedJson, encoding: .utf8) {
			return jsonString
		}
		return "\(self.jsonObject)"
	}
}

public extension Json {
	@dynamicMemberLookup
	public class MemberStub {
		var key: String
		init(key: String = "") {
			self.key = key
		}
		public subscript(dynamicMember member: String) -> MemberStub {
			get {
				let validKey: String
				if self.key.isEmpty {
					validKey = member
				} else {
					validKey = "\(self.key).\(member)"
				}
				return MemberStub(key: validKey)
			} set {
				self.key = newValue.key
			}
		}
	}
}
