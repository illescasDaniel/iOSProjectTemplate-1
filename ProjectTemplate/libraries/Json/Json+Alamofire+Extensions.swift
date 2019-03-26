//
//  Json+Alamofire+Extensions.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 22/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

#if canImport(Alamofire)
import struct Alamofire.DataResponse
import enum Alamofire.Result

public extension Alamofire.DataResponse {
	public var jsonResult: Result<Json> {
		return Result<Json>(value: { () -> Json in
			switch self.result {
			case .success(let jsonResult):
				return Json(jsonResult)
			case .failure(let error):
				throw error
			}
		})
	}
}
#endif
