//
//  AppTheme.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 16/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

enum AppTheme: AppThemesProtocol {
	enum Theme: String, AppThemeProtocol {
		case dark
		case light
	}
	static var current = Theme.dark
}

enum AppColor {
	
	enum TableView: String, AppThemeColorProtocol {
		
		case header
		case background
		
		var value: UIColor {
			switch self.dynamicColor {
			case .some(let dynamicColor):
				return dynamicColor
			case .none:
				switch self {
				case .header:
					return AppThemeColor<AppTheme>([.dark: .black, .light: .blue]).current
				case .background:
					return AppThemeColor<AppTheme>([.dark: .black, .light: .darkGray]).current
				}
			}
		}
	}
	
	enum Basic: String, AppThemeColorProtocol {
		
		case bluePerl
		
		var value: UIColor {
			switch self.dynamicColor {
			case .some(let dynamicColor):
				return dynamicColor
			case .none:
				switch self {
				case .bluePerl:
					return AppThemeColor<AppTheme>([.dark: .black, .light: .blue]).current
				}
			}
		}
	}
}
