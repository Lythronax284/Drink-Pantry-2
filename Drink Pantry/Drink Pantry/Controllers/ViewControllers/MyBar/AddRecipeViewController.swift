//
//  AddRecipeViewController.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 10/14/20.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    @IBOutlet var ingredientTextFieldCollection: [UITextField]!
    @IBOutlet weak var saveRecipeButton: UIButton!
    
    var itemCount = 2
    var startCount = 3
    var recipe: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        itemCount = incrementCount(itemCount)
        self.ingredientTextFieldCollection[itemCount].isHidden = true
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        saveRecipe()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        while startCount < 15 {
            ingredientTextFieldCollection[startCount].isHidden.toggle()
            startCount = incrementCount(startCount)
        }
    }
    
    func incrementCount(_ num: Int) -> Int {
        var count = num
        if count < 14 {
            count += 1
        }
        return count
    }
    
    func saveRecipe() {
        for i in ingredientTextFieldCollection {
            guard let ingredientText = i.text, !ingredientText.isEmpty || ingredientText != "" else {
                print(recipe); return }
            recipe.append(ingredientText)
        }
    }
}

