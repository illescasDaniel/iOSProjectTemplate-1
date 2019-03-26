//
//  Cache.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 16/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

public class Cache<Key: AnyObject, Value: AnyObject> {
	
	public typealias Integer = NSNumber
	public typealias String = NSString
	
	private let cacheData = NSCache<Key, Value>()
	
	public subscript(key: Key) -> Value? {
		get {
			return self.cacheData.object(forKey: key)
		} set {
			if let newValue = newValue {
				self.cacheData.setObject(newValue, forKey: key)
			}
		}
	}
}

