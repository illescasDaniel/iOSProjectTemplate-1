//
//  ViewController.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 11/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

/*import MediaPlayer

extension UIView {
	
	// Using a function since `var image` might conflict with an existing variable
	// (like on `UIImageView`)
	func asImage() -> UIImage {
		if #available(iOS 10.0, *) {
			let renderer = UIGraphicsImageRenderer(bounds: bounds)
			return renderer.image { rendererContext in
				layer.render(in: rendererContext.cgContext)
			}
		} else {
			UIGraphicsBeginImageContext(self.frame.size)
			self.layer.render(in:UIGraphicsGetCurrentContext()!)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			return UIImage(cgImage: image!.cgImage!)
		}
	}
}
*/

class ViewController: UIViewController {
	
	enum TestError: Error {
		case lol
	}
	
	@IBOutlet weak var myLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	
	func test(n: Int) -> Promise<Int> {
		return Promise { fulfill, reject in
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				if n == 10 {
					fulfill(10)
				} else {
					reject(TestError.lol)
				}
			}
		}
	}
	
	func test0(n: Int) -> Future<Int> {
		return Future { fulfill, reject in
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				if n == 10 {
					fulfill(10)
				} else {
					reject(TestError.lol)
				}
			}
		}
	}
	
	func test2() -> Future<Int> {
		return Future { fulfill, reject in
			let value = try? Futures.await(self.test0(n: 10))
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				if value == 10 {
					fulfill(99)
				} else {
					reject(TestError.lol)
				}
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		/*Async.main(after: 2) {
			self.myLabel.text = "text after 2s"
		}.main(after: 1) {
			self.myLabel.text = UserDefaultsManager.standard.defaultUsername
		}.main(after: 1) {
			self.myLabel.text = "hi again"
			self.myLabel.textColor = UIColor(hex: "505050")
		}.main(after: 2) {
			self.myLabel.text = AppFolder.Documents.baseURL.description
		}.main(after: 2) {
			self.myLabel.font = UIFont.fontAwesome(ofSize: 20, style: .brands)
			self.myLabel.text = String.fontAwesomeIcon(name: .github)
		}.main(after: 2) {
			AF.request("https://jsonplaceholder.typicode.com/todos/1").responseJSON { response in
				switch response.jsonResult {
				case .success(let json):
					print(json)
					
					json.userId = [
						"name": "Daniel",
						"age": 22
					]
					print(json["userId.name"] ?? "--")
					print(json[\.userId.name])
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
		}*/
		Logger.log("hi!!")
		TODO.Service.todo(by: 1).then { todoViewModel in
			self.myLabel.attributedText = todoViewModel.attributedTitle
			Logger.log(Resource.SavedData.LocalConfig.Other.isXEnabled.value)
			print("----")
			print(Logger.currentLog)
			print("----")
			print(Logger.lastLog)
		}.catch { error in
			Logger.log(error.localizedDescription)
		}
		
		/*test2().then { value in
			print(value)
		}.catch { error in
			print(error)
		}
		
		DispatchQueue.global().async {
			let group = DispatchGroup()
			
			var test: Int? = nil
			group.enter()
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				test = 10000
				group.leave()
			}
			/*dg.notify(queue: .main) {
			print(test)
			}*/
			group.wait()
			print(test ?? "--")
		}*/
	}
	
	// Peek
	
	/*override var canBecomeFirstResponder: Bool {
		return true
	}
	
	override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		UIApplication.shared.keyWindow?.peek.handleShake(motion)
	}*/
}
