//
//  DrinkController.swift
//  drinkAPI
//
//  Created by Alex Lundquist on 10/5/20.
//


import Foundation
import class UIKit.UIImage
class DrinkController {
	
	static let shared = DrinkController()
	
	
	func fetchDrink(path: APIRoute, termName: String = "", termValue: String = "", completion: @escaping (Result<[Drink]?, DrinkError>) -> Void) {
		guard let url = path.startURL else { preconditionFailure("Failed to build URL")}
		var finalURL: URL
		switch path{
			case .filter:
				var components = URLComponents()
				components.queryItems = [URLQueryItem(name: termName, value: termValue)]
				guard let builtURL = components.url(relativeTo: url) else { return completion(.failure(.invalidURL))}
				finalURL = builtURL
			case .search:
				var components = URLComponents()
				components.queryItems = [URLQueryItem(name: termName, value: termValue)]
				guard let builtURL = components.url(relativeTo: url) else { return completion(.failure(.invalidURL))}
				finalURL = builtURL
			case .random:
				finalURL = url
			case .tenRandom:
				finalURL = url
			default:
				return completion(.failure(.invalidURL))
				
		}
		
		URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
			if let error = error {
				print(response as! HTTPURLResponse)
				return completion(.failure(.thrownError(error)))
			}
			DispatchQueue.main.async {
				guard let data = data else { return }
				guard let fetchedData = try? JSONDecoder().decode(DrinkObject.self, from: data) else { return completion(.failure(.unableToDecode))}
				completion(.success(fetchedData.drinks))
			}
		}.resume()
	} //End of fetchDrink
	
	func fetchImage(imageURL: String, isIngredient: Bool = false, thumb: Bool = false, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
		var url: URL
		
		switch isIngredient {
			case true:
				guard let ingredientUrl = APIRoute.ingredientImage.startURL else { preconditionFailure("Failed to build URL")}
				print(imageURL)
				url = ingredientUrl.appendingPathComponent("\(imageURL)-Small".lowercased()).appendingPathExtension("png")
				print(url.absoluteURL)
			case false:
				switch thumb {
					case false:
						guard let imageUrl = URL(string: imageURL) else { return completion(.failure(.invalidURL))}
						url = imageUrl
					case true:
						guard let imageUrl = URL(string: imageURL) else { return completion(.failure(.invalidURL))}
						url = imageUrl.appendingPathComponent("preview")
				}
		}
		
		URLSession.shared.dataTask(with: url) { (data, _, error) in
			if let error = error {
				return completion(.failure(.thrownError(error)))
			}
			DispatchQueue.main.async {
				guard let data = data else { return }
				guard let image = UIImage(data: data) else { return completion(.failure(.noData))}
				completion(.success(image))
			}
		}.resume()
	}
}//End of Class

