//
//  Drinks.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 8/26/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//

import Foundation
struct Drinks: Codable {
                                // API
    var name: String?           // strDrink
    var category: String?       // strCategory
    var glassType: String?      // strGlass
    var instructions: String?   // strInstructions
    var dateModified: Date?     // dateModified
    var img: String?            // strDrinkThumb
    var favorite: Bool = false
       
    mutating func changeImg (url: String){
        img = url
    }
    
    // CONVERT INTO A GETTER/SETTER COMPUTED PROPERTY
    mutating func isFavorite (fav: Bool){
        favorite = fav
    }

}
