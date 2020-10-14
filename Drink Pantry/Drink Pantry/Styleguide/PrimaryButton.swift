//
//  PrimaryButton.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/14/20.
//

import UIKit

class PrimaryButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .primaryPeach
        self.setTitleColor(.primaryPink, for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.primaryPink.cgColor
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.titleLabel?.font = Fonts.devangariBold
    }
    
   
    
    
}
