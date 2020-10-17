//
//  Drink.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 9/28/20.
//

import Foundation

struct DrinkObject:Equatable, Decodable{
	let drinks: [Drink]
	// let drinks: [[String: String?]]
}

struct Drink: Equatable, Decodable {
	
	let idDrink: String
	let strDrink: String
	let strDrinkAlternate: String?
	let strVideo: String?
	let strCategory: String?
	let strIBA: String?
	let strAlcoholic: String?
	let strGlass: String?
	let strInstructions: String?
	let strDrinkThumb: String?
	let strIngredient1: String?
	let strIngredient2: String?
	let strIngredient3: String?
	let strIngredient4: String?
	let strIngredient5: String?
	let strIngredient6: String?
	let strIngredient7: String?
	let strIngredient8: String?
	let strIngredient9: String?
	let strIngredient10: String?
	let strIngredient11: String?
	let strIngredient12: String?
	let strIngredient13: String?
	let strIngredient14: String?
	let strIngredient15: String?
	let strMeasure1: String?
	let strMeasure2: String?
	let strMeasure3: String?
	let strMeasure4: String?
	let strMeasure5: String?
	let strMeasure6: String?
	let strMeasure7: String?
	let strMeasure8: String?
	let strMeasure9: String?
	let strMeasure10: String?
	let strMeasure11: String?
	let strMeasure12: String?
	let strMeasure13: String?
	let strMeasure14: String?
	let strMeasure15: String?
	let strCreativeCommonsConfirmed: String?
	let dateModified: String?
}


