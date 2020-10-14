//
//  SecondaryButton.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/14/20.
//

import UIKit

class SecondaryButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .primaryPink
        self.setTitleColor(.white, for: .normal)
        //self.layer.borderWidth = 2
        //self.layer.borderColor = CustomColors.primaryPink?.cgColor
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.titleLabel?.font = Fonts.devangariBold
    }
}
