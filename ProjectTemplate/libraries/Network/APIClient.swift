//
//  APIClient.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIClient {
	associatedtype APIConfigType: APIConfiguration
	static func request<RequestType: Decodable>(_ config: APIConfigType) -> Future<RequestType>
}

public extension APIClient {
	public static func request<RequestType: Decodable>(_ config: APIConfigType) -> Future<RequestType> {
		return Future { fulfill, reject in
			AF.request(config).responseDecodable { (response: DataResponse<RequestType>) in
				switch response.result {
				case .success(let response_):
					fulfill(response_)
				case .failure(let error):
					reject(error)
				}
			}
		}
	}
}
