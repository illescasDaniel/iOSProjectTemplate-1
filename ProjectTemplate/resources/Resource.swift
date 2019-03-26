//
//  Resource.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 16/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

typealias AssetRef = Asset
typealias ColorRef = Color

enum Resource {
	typealias Asset = AssetRef
	typealias Color = ColorRef
	typealias Localization = L10n
	enum SavedData {
		enum LocalConfig {
			static var appUserDefaults = UserDefaults.standard // you can replace it if you want
		}
		typealias DynamicConfig = DynamicAppConfig
		enum Cached {
			typealias URLHash = NSNumber
			static let image = Cache<URLHash, UIImage>()
			// ...
		}
	}
}
