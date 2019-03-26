//
//  AppConfig.swift
//  QR Code Reader
//
//  Created by Daniel Illescas Romero on 15/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

final class DynamicAppConfig: Codable {
	
	struct ViewControllerConfig: Codable {
		struct ViewConfig: Codable {
			let state: ViewState
			let backgroundColor: Color?
		}
		let views: [String: ViewConfig]
		let state: ViewState
	}
	
	let viewControllers: [String: ViewControllerConfig]
	let localization: [String: String]
	let colors: [String: Color]
	private let assets: [String: URL]
	var retrievedAssets: [String: UIImage] = [:]
	
	//
	
	enum CodingKeys: String, CodingKey {
		case viewControllers, localization, colors, assets
	}
	
	init(viewControllers: [String: ViewControllerConfig], localization: [String: String], colors: [String: Color], assets: [String: URL]) {
		self.viewControllers = viewControllers
		self.localization = localization
		self.colors = colors
		self.assets = assets
		self.initializeAssets()
	}
	
	static var shared: DynamicAppConfig? = nil
}

//

extension DynamicAppConfig {
	private func initializeAssets() {
		for asset in self.assets {
			let request = URLRequest(url: asset.value, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 25)
			let task = URLSession.shared.dataTask(with: request) { data, _, _ in
				if let data = data, let image = UIImage(data: data) {
					self.retrievedAssets[asset.key] = image
				}
			}
			task.resume()
		}
	}
	convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let viewControllers = try container.decodeIfPresent([String: ViewControllerConfig].self, forKey: .viewControllers) ?? [:]
		let localization = try container.decodeIfPresent([String: String].self, forKey: .localization) ?? [:]
		let colorsDict = try container.decodeIfPresent([String: Color].self, forKey: .colors) ?? [:]
		//let colors = Dictionary(uniqueKeysWithValues: colorsDict.map { (k,v) in (Color(stringLiteral: k), v) })
		let assets = try container.decodeIfPresent([String: URL].self, forKey: .assets) ?? [:]
		self.init(viewControllers: viewControllers, localization: localization, colors: colorsDict, assets: assets)
	}
}

//

extension DynamicAppConfig.ViewControllerConfig {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let views = try container.decodeIfPresent([String: ViewConfig].self, forKey: .views) ?? [:]
		let state = try container.decodeIfPresent(DynamicAppConfig.ViewState.self, forKey: .state) ?? .normal
		self.init(views: views, state: state)
	}
}
extension DynamicAppConfig.ViewControllerConfig.ViewConfig {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let state = try container.decodeIfPresent(DynamicAppConfig.ViewState.self, forKey: .state) ?? .normal
		let backgroundColor = try container.decodeIfPresent(DynamicAppConfig.Color.self, forKey: .backgroundColor) ?? nil
		self.init(state: state, backgroundColor: backgroundColor)
	}
}
