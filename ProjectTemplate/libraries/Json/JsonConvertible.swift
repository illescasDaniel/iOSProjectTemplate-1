//
//  JsonConvertible.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 19/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

public protocol JsonConvertible {
	var json: Json { get }
}
public extension JsonConvertible {
	var json: Json {
		return Json(self)
	}
}

extension String: JsonConvertible {}
extension Int: JsonConvertible {}
extension Bool: JsonConvertible {}
extension Double: JsonConvertible {}
extension Array: JsonConvertible {}
extension Dictionary: JsonConvertible {}

public extension Encodable {
	public var inJson: Json {
		return Json(self)
	}
}
