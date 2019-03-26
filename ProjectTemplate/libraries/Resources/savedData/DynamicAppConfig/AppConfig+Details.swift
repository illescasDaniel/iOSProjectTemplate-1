//
//  AppConfig.swift
//  QR Code Reader
//
//  Created by Daniel Illescas Romero on 14/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

extension DynamicAppConfig {
	
	//private static let key = "illescasDaniel_941_apiKey"
	//static let remoteURL = "https://illescasdaniel-appsconfig.herokuapp.com/api/codeReaderConfig/\(AppConfig.key)" //
	static let remoteURL = "https://pastebin.com/raw/urz2t2WE"
	
	static func shared(_ appConfigHandler: @escaping (DynamicAppConfig) -> Void) {
		if let config = DynamicAppConfig.shared {
			appConfigHandler(config)
			return
		}
		DynamicAppConfig.loadSavedConfig(appConfigHandler)
		guard let url = URL(string: DynamicAppConfig.remoteURL) else { return }
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 25)
		let task = DynamicAppConfig.urlSession.dataTask(with: request) { data, response, error in
			
			/*do {
				try JSONDecoder().decode(AppConfig.self, from: data!)
			} catch {
				print(error)
			}*/
			
			guard let data = data, let config = try? JSONDecoder().decode(DynamicAppConfig.self, from: data) else {
				//Log.with(message: "Error loading config", type: .error, category: .MC)
				print("Error loading config")
				return
			}
			DynamicAppConfig.shared = config
			UserDefaults.standard.set(data, forKey: "AppConfig_\(Bundle.main.bundleIdentifier ?? "barcode")")
			appConfigHandler(config)
		}
		task.resume()
	}
	
	private static var urlSession: URLSession {
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = 25
		sessionConfig.timeoutIntervalForResource = 40
		sessionConfig.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
		sessionConfig.urlCache?.removeAllCachedResponses()
		return URLSession(configuration: sessionConfig)
	}
	
	private static func loadSavedConfig(_ appConfigHandler: @escaping (DynamicAppConfig) -> Void) {
		if let configData = UserDefaults.standard.data(forKey: "AppConfig_\(Bundle.main.bundleIdentifier ?? "barcode")"),
			let config = try? JSONDecoder().decode(DynamicAppConfig.self, from: configData) {
			DynamicAppConfig.shared = config
			appConfigHandler(config)
			return
		}
	}
}
