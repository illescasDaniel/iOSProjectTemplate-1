//
//  ViewModel.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 10/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

public protocol ViewModel {
	associatedtype Model
	var model: Model { get set }
	init(model: Model)
	static func map(from model: Model) -> Self
}

public extension ViewModel {
	static func map(from model: Model) -> Self {
		return Self(model: model)
	}
}
