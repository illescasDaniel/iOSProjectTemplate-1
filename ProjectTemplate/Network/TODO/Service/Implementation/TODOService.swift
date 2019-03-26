//
//  TODOService.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension TODO {
	enum Service: TODOServiceProtocol {
		
		typealias Client = TODO.Internal.ApiClient
	
		static func todos() -> Future<ViewModels.TODOItemViewModel> {
			return Client.todos()
				.map(Models.TODOItem.map)
				.map(ViewModels.TODOItemViewModel.map)
		}
		
		static func todo(by id: Int) -> Future<ViewModels.TODOPostViewModel> {
			return Client.todo(id: id)
				.map(Models.TODOPost.map)
				.map(ViewModels.TODOPostViewModel.map)
		}
	}
}
