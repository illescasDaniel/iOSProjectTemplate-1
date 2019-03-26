//
//  APIConfiguration.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
	associatedtype ApiClient: APIClient
	var baseURL: URLConvertible { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var bodyParameters: Parameters? { get }
}

public extension APIConfiguration {
	public func asURLRequest() throws -> URLRequest {
		
		let url = try self.baseURL.asURL()
		
		var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
		urlRequest.httpMethod = self.method.rawValue
		urlRequest.setValue(ContentType.json.rawValue,
							forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
		urlRequest.setValue(ContentType.json.rawValue,
							forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
		
		if let bodyParameters = bodyParameters {
			do {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
			} catch {
				throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
			}
		}
		
		return urlRequest
	}
}
