//
//  Color.swift
//  QR Code Reader
//
//  Created by Daniel Illescas Romero on 15/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

extension DynamicAppConfig {
	struct Color: Codable, Hashable {
		
		let red: CGFloat
		let green: CGFloat
		let blue: CGFloat
		let alpha: CGFloat
		
		var uiColor: UIColor {
			return UIColor(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
		}
	}
}
extension DynamicAppConfig.Color {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let red = try container.decodeIfPresent(CGFloat.self, forKey: .red) ?? 1
		let green = try container.decodeIfPresent(CGFloat.self, forKey: .green) ?? 1
		let blue = try container.decodeIfPresent(CGFloat.self, forKey: .blue) ?? 1
		let alpha = try container.decodeIfPresent(CGFloat.self, forKey: .alpha) ?? 1
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
extension DynamicAppConfig.Color: ExpressibleByStringLiteral {
	init(stringLiteral value: StringLiteralType) {
		if let data = value.data(using: .utf8),
			let dict = try? JSONDecoder().decode([String: CGFloat].self, from: data),
			let dictData = try? JSONEncoder().encode(dict),
			let color = try? JSONDecoder().decode(DynamicAppConfig.Color.self, from: dictData) {
			self.init(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
		} else {
			self.init(red: 0, green: 0, blue: 0, alpha: 0)
		}
	}
}

//

extension UIColor {
	var color: DynamicAppConfig.Color {
		var (r,g,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0,0,0,0)
		self.getRed(&r, green: &g, blue: &b, alpha: &a)
		return DynamicAppConfig.Color(red: r, green: g, blue: b, alpha: a)
	}
}
