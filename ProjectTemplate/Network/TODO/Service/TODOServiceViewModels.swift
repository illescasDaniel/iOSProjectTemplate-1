//
//  TODOServiceViewModels.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension TODO.Service {
	enum ViewModels {
		
		struct TODOItemViewModel: ViewModel {
			var model: TODO.Service.Models.TODOItem
			var titleText: String {
				return self.model.title.uppercased()
			}
			var completedText: String {
				return self.model.completed ? "✓" : "✗"
			}
		}
		
		struct TODOPostViewModel: ViewModel {
			var model: TODO.Service.Models.TODOPost
			var attributedTitle: NSAttributedString {
				let title = self.model.title.uppercased()
				return NSAttributedString(string: title, attributes: [
					.font: UIFont.boldSystemFont(ofSize: 15),
					.foregroundColor: UIColor.white,
					.backgroundColor: UIColor.blue
				])
			}
		}
	}
}
