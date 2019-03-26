//
//  ViewState.swift
//  QR Code Reader
//
//  Created by Daniel Illescas Romero on 15/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension DynamicAppConfig {
	enum ViewState: String, Codable {
		case normal
		case hidden
		case disabled
		case notHidden
	}
}
