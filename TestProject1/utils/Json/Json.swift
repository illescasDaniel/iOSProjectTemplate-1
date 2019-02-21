//
//  Json.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 19/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

@dynamicMemberLookup
class Json {
	
	private var parent: (String, Json)?
	private var jsonObject: Any
	
	static var null: Json {
		return Json()
	}
	
	// MARK: - Initializers
	
	fileprivate init(value: Any? = NSDictionary()) {
		self.jsonObject = value ?? NSDictionary()
	}
	
	convenience init(data: Data) {
		let decodedJson = try? JSONSerialization.jsonObject(with: data, options: [])
		self.init(value: decodedJson)
	}
	
	convenience init<T>(_ object: T?, parent: (String, Json)? = nil) {
		if object is Json, let json = object as? Json {
			self.init(json.jsonObject)
		} else if object is Data, let data = object as? Data {
			self.init(data: data)
		} else if let object = object, JSONSerialization.isValidJSONObject(object), let jsonData = try? JSONSerialization.data(withJSONObject: object) {
			self.init(data: jsonData)
		} else {
			self.init(value: object)
		}
		self.parent = parent
	}
	
	convenience init<T: Encodable>(_ encodableObject: T) {
		if let encodedObject = try? JSONEncoder().encode(encodableObject) {
			self.init(data: encodedObject)
		} else {
			self.init()
		}
	}
	
	convenience init(raw rawJson: String) {
		if let jsonData = rawJson.data(using: .utf8) {
			self.init(data: jsonData)
		} else {
			self.init(value: rawJson)
		}
	}
	
	// MARK: - Subscripts
	
	subscript(dynamicMember member: String) -> Json {
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
	
	subscript(dynamicMember member: String) -> Any {
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
	
	subscript(_ index: Int) -> Json {
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
	
	subscript(_ index: Int) -> Any {
		get {
			return self[index] as Json
		} set {
			self[index] = Json(newValue)
		}
	}
	
	subscript(_ keyPath: ReferenceWritableKeyPath<Json,Json>) -> Json {
		get {
			return self[keyPath: keyPath]
		} set {
			self[keyPath: keyPath] = newValue
		}
	}
	
	/// Use with **caution**, since an invalid keypath produces an uncatchable exception (in swift)
	subscript<T>(_ keyPath: String) -> T? {
		return self.nsdictionary?.value(forKeyPath: keyPath) as? T
	}
	
	// MARK: - Codable
	
	func decoded<T: Decodable>() -> T? {
		if let jsonData = self.encoded() {
			return try? JSONDecoder().decode(T.self, from: jsonData)
		}
		return nil
	}
	
	func encoded() -> Data? {
		if JSONSerialization.isValidJSONObject(self.jsonObject), let jsonData = try? JSONSerialization.data(withJSONObject: self.jsonObject, options: .prettyPrinted) {
			return jsonData
		}
		return nil
	}
	
	// MARK: -
	
	var string: String? {
		return self.jsonObject as? String
	}
	var int: Int? {
		return self.jsonObject as? Int
	}
	var bool: Bool? {
		return self.jsonObject as? Bool
	}
	var double: Double? {
		return self.jsonObject as? Double
	}
	var array: [Any]? {
		return self.jsonObject as? [Any]
	}
	var dictionary: [String: Any]? {
		return self.jsonObject as? [String: Any]
	}
	var nsdictionary: NSDictionary? {
		return self.jsonObject as? NSDictionary
	}
	var any: Any {
		return self.jsonObject
	}
	
	//
	
	var isJsonEmpty: Bool {
		return self.dictionary?.isEmpty == true
	}
}

extension Json: CustomStringConvertible {
	var description: String {
		if let encodedJson = self.encoded(), let jsonString = String(data: encodedJson, encoding: .utf8) {
			return jsonString
		}
		return "\(self.jsonObject)"
	}
}
