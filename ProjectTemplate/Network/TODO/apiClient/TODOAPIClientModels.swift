//
//  TODOResponse.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension TODO.Internal.ApiClient {
	enum Models {
		/// For TODOEndpoint.todos()
		struct TODOResponse: Decodable {
			let userId: Int
			let id: Int
			let title: String
			let completed: Bool
		}
		
		// For TODOEndpoint.todo(id: Int)
		struct TODOPostResponse: Decodable {
			let userId: Int
			let id: Int
			let title: String
		}
	}
}
