//
//  TODOMockService.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 25/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension TODO {
	enum MockService: TODOServiceProtocol {
		
		typealias Client = TODO.Internal.ApiClient
		
		static func todos() -> Future<Service.ViewModels.TODOItemViewModel> {
			return Future { onFulfill, _ in
				onFulfill(.init(model: .init(title: "Test", completed: true)))
			}
		}
		
		static func todo(by id: Int) -> Future<Service.ViewModels.TODOPostViewModel> {
			return Future { onFulfill, _ in
				onFulfill(.init(model: .init(title: "Title")))
			}
		}
	}
}
