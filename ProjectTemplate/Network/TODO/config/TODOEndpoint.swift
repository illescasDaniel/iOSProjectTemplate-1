//
//  TODOEndpoint.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Alamofire

extension TODO.Internal {
	// sourcery: url = "https://jsonplaceholder.typicode.com"
	enum Endpoint: APIConfiguration {
		typealias ApiClient = TODO.Internal.ApiClient
		// sourcery: method = GET, path = "/todos", response = TODOResponse
		case todos()
		// sourcery: method = GET, path = "/posts/\(id)", response = TODOPostResponse
		case todo(id: Int)
	}
}
