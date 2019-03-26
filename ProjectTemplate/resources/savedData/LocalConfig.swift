//
//  DefaultsKey.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Resource.SavedData.LocalConfig {
	enum Profile {
		static var username = UserDefault(key: "Profile.username", defaultValue: "none")
		// ...
	}
	enum Other {
		static var isXEnabled = UserDefault(key: "Other.isXEnabled", defaultValue: false)
		// ...
	}
}
