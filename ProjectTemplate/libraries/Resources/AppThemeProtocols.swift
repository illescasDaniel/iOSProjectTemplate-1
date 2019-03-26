//
//  ThemeColor.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 16/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

protocol AppThemeProtocol: Hashable, RawRepresentable where RawValue == String {}

protocol AppThemesProtocol {
	associatedtype Theme: AppThemeProtocol
	static var current: Theme { get set }
}

struct AppThemeColor<AppThemeType: AppThemesProtocol> {
	
	private let themeColor: [AppThemeType.Theme: UIColor]
	
	init(_ themeColor: [AppThemeType.Theme: UIColor]) {
		self.themeColor = themeColor
	}
	
	var current: UIColor {
		return self.themeColor[AppThemeType.current] ?? .clear
	}
}

protocol AppThemeColorProtocol: RawRepresentable where RawValue == String {
	var value: UIColor { get }
	var dynamicColor: UIColor? { get }
}
extension AppThemeColorProtocol {
	var dynamicColor: UIColor? {
		print("\(Self.self).\(self.rawValue)")
		return DynamicAppConfig.shared?.colors["\(Self.self).\(self.rawValue)"]?.uiColor
	}
}

//
