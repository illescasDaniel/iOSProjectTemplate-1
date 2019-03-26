//
//  TODOServiceProtocol.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 25/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

protocol TODOServiceProtocol: APIService where Client == TODO.Internal.ApiClient {
	static func todos() -> Future<TODO.Service.ViewModels.TODOItemViewModel>
	static func todo(by id: Int) -> Future<TODO.Service.ViewModels.TODOPostViewModel>
}

