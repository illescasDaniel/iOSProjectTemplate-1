//
//  DiskStorage.swift
//  ProjectTemplate
//
//  Created by Daniel Illescas Romero on 16/03/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation

extension Resource.SavedData {
	public class DiskStorage {
		
		public static let manager = FileManager.default
		
		private static let docsFolder = DiskStorage.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		public static let location = DiskStorage.docsFolder.appendingPathComponent("SavedFiles")
		
		public struct File {
			public let name: String
			public let data: Data
		}
		
		public static func save(file: File) {
			let filePath = DiskStorage.location.appendingPathComponent(file.name)
			DiskStorage.createDir()
			DiskStorage.manager.createFile(atPath: filePath.path, contents: file.data)
		}
		
		public static func file(named fileName: String) -> File? {
			let filePath = DiskStorage.location.appendingPathComponent(fileName)
			if let data = DiskStorage.manager.contents(atPath: filePath.path) {
				return File(name: fileName, data: data)
			}
			return nil
		}
		
		private static func createDir() {
			if !DiskStorage.manager.fileExists(atPath: DiskStorage.location.path) {
				try? DiskStorage.manager.createDirectory(at: DiskStorage.location)
			}
		}
	}
}
