//
//  ViewController.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 11/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var myLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		Async.main(after: 2) {
			self.myLabel.text = L10n.Test.label
		}.main(after: 1) {
			self.myLabel.text = UserDefaultsManager.standard.defaultUsername
		/*}.main(after: 1) {
			self.myLabel.text = "hi again"
			self.myLabel.textColor = UIColor(hex: "505050")
		}.main(after: 2) {
			self.myLabel.text = AppFolder.Documents.baseURL.description
		}.main(after: 2) {
			self.myLabel.font = UIFont.fontAwesome(ofSize: 20, style: .brands)
			self.myLabel.text = String.fontAwesomeIcon(name: .github)*/
		}.main(after: 2) {
			Alamofire.request("https://jsonplaceholder.typicode.com/todos/1").responseJSON { response in
				switch response.result {
				case .success(let value):
					let json = Json(value)
					print(json)
					
					json.userId = [
						"name": "Daniel",
						"age": 22
					]
					print(json["userId.name"] ?? "--")
					//let userName = json[\.userId.name]
					//print(userName)
					print(json)
					
					if let title = json.title.string {
						self.myLabel.text = title
					} else {
						Logger.log("No title", type: .error, category: .network)
					}
					
				case .failure(let error):
					Logger.log(error.localizedDescription)
				}
			}
		}
		//myLabel.font = UIFont.fontAwesome(ofSize: 20, style: .brands)
	}
	
	// Peek
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		// iOS 10 now requires device motion handlers to be on a UIViewController
		UIApplication.shared.keyWindow?.peek.handleShake(motion)
	}
}
