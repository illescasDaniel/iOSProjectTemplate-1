//
//  LoadConfig+Extensions.swift
//  QR Code Reader
//
//  Created by Daniel Illescas Romero on 15/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

/*extension UIColor {
	var orDynamic: UIColor {
		return DynamicAppConfig.shared?.colors[self.color]?.uiColor ?? self
	}
	static func get(_ uiColor: UIColor, _ completion: @escaping (UIColor) -> Void) {
		if let configColor = DynamicAppConfig.shared?.colors[uiColor.color]?.uiColor {
			completion(configColor)
		} else {
			completion(uiColor)
			DynamicAppConfig.shared { config in
				if let colorToReplace = config.colors[uiColor.color] {
					completion(colorToReplace.uiColor)
				}
			}
		}
	}
}*/

extension String {
	var localized: String {
		return DynamicAppConfig.shared?.localization[self] ?? NSLocalizedString(self, comment: "")
	}
	func localized(_ completion: @escaping (String) -> Void) {
		if let localizedSavedString = DynamicAppConfig.shared?.localization[self] {
			completion(localizedSavedString)
		} else {
			completion(NSLocalizedString(self, comment: ""))
			DynamicAppConfig.shared { config in
				if let localizedString = config.localization[self] {
					completion(localizedString)
				}
			}
		}
	}
}

extension UIView {
	func loadConfig(_ viewConfig: DynamicAppConfig.ViewControllerConfig.ViewConfig?) {
		
		guard let viewConfig = viewConfig else { return }
		
		let (state, bgColor) = (viewConfig.state, viewConfig.backgroundColor)
		
		DispatchQueue.main.async {
			switch state {
			case .normal: break
			case .hidden:
				self.isHidden = true
			case .notHidden:
				self.isHidden = false
			case .disabled:
				if let control = self as? UIControl {
					control.isEnabled = false
				}
			}
			if let color = bgColor?.uiColor {
				self.backgroundColor = color
			}
		}
	}
}
extension UIViewController {
	func loadConfig(_ vcConfig: DynamicAppConfig.ViewControllerConfig?) {
		
		guard let vcConfig = vcConfig else { return }
		
		let viewsDictionary = vcConfig.views
		
		for viewDict in viewsDictionary {
			if let view = self.value(forKey: viewDict.key) as? UIView {
				view.loadConfig(viewDict.value)
			}
		}
	}
}
extension UITabBarController {
	
	func loadConfig(for viewControllers: [String: DynamicAppConfig.ViewControllerConfig]?) {
		
		guard let viewControllers = viewControllers else { return }
		
		for (viewControllerName, config) in viewControllers {
			if let viewController = self.value(forKey: viewControllerName) as? UIViewController {
				
				viewController.loadConfig(config)
				
				var vcIndex: Int? = nil
				for (index, subViewcontroller) in (self.viewControllers ?? []).enumerated() {
					if subViewcontroller is UINavigationController, let navController = subViewcontroller as? UINavigationController, navController.viewControllers.first(where: { $0 == viewController }) != nil {
						vcIndex = index
					} else if subViewcontroller == viewController {
						vcIndex = index
					}
				}
				
				if let controllerIndex = vcIndex {
					let state = config.state
					switch state {
					case .normal: break
					case .hidden: break // ... remove(?) tab bar item? might be 'dangerous'
					case .notHidden: break
					case .disabled:
						DispatchQueue.main.async {
							self.tabBar.items?[controllerIndex].isEnabled = false
						}
					}
				}
			}
		}
	}
}

extension UIImage {
	convenience init?(named: String) {
		if let cgImage = DynamicAppConfig.shared?.retrievedAssets[named]?.cgImage {
			self.init(cgImage: cgImage)
		} else {
			self.init(named: named, in: nil, compatibleWith: nil)
		}
	}
}
