//
//  DrinkAPIRoute.swift
//  drinkAPI
//
//  Created by Alex Lundquist on 10/5/20.
//

import Foundation

enum APIRoute: Equatable {
	static let baseURL = "https://www.thecocktaildb.com/"
	static let api = "api/json/v2/9973533/"
	
	//	case drinkImage
	case ingredientImage
	case search
	case lookup
	case filter
	case list
	case random
	case tenRandom
	
	var path: String {
		switch self {
			//			case .drinkImage:
			//				return "images/media/drink/"
			case .ingredientImage:
				return "images/ingredients/"
			case .search:
				return "search.php"
			case .lookup:
				return "lookup.php"
			case .filter:
				return "filter.php"
			case .list:
				return "list.php"
			case .random:
				return "random.php"
			case .tenRandom:
				return "randomselection.php"
		}
	}
	var startURL: URL? {
		switch path {
			case APIRoute.search.path, APIRoute.random.path, APIRoute.tenRandom.path:
				let url = URL(string: APIRoute.baseURL)?.appendingPathComponent(APIRoute.api).appendingPathComponent(path)
				return url
			case APIRoute.lookup.path, APIRoute.filter.path, APIRoute.list.path:
				let url = URL(string: APIRoute.baseURL)?.appendingPathComponent(APIRoute.api).appendingPathComponent(path)
				return url
			case APIRoute.ingredientImage.path:
				let url = URL(string: APIRoute.baseURL)?.appendingPathComponent(path)
				return url
			default:
				let url = URL(string: APIRoute.baseURL)?.appendingPathComponent(path)
				return url
		}
	}
}
