//
//  PokeCell.swift
//  pokedex 3
//
//  Created by brenda saavedra on 12/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        layer.cornerRadius = 5
        
    }
    
    func configureCell(pokemon:Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
