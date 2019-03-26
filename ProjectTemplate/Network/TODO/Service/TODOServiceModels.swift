//
//  TODOBusinessModels.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension TODO.Service {
	enum Models {
		struct TODOItem: MappableModel {
			let title: String
			let completed: Bool
			typealias EndpointModel = TODO.Internal.ApiClient.Models.TODOResponse
			static func map(from endpointModel: EndpointModel) -> TODOItem {
				return .init(title: endpointModel.title, completed: endpointModel.completed)
			}
		}
		struct TODOPost: MappableModel {
			let title: String
			typealias EndpointModel = TODO.Internal.ApiClient.Models.TODOPostResponse
			static func map(from endpointModel: EndpointModel) -> TODOPost {
				return .init(title: endpointModel.title)
			}
		}
	}
}


