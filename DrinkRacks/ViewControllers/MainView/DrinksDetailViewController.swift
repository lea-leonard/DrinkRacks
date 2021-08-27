//
//  DrinksDetailViewController.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 8/26/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//

import UIKit

class DrinksDetailViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var viewDrinkName: UIView!
    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var viewGlassType: UIView!
    @IBOutlet weak var viewInstruction: UIView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    
    //: INSTANCE VARIABLES
    var drinkDetail : Drinks?
    var isFavorite : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: UPDATE UI INTERFACE
        self.viewDrinkName.layer.cornerRadius = 50
        self.viewFavorite.layer.cornerRadius = 15
        self.viewGlassType.layer.cornerRadius = 15
        
        self.viewInstruction.layer.cornerRadius = 15
        
    }
    
    // MARK: IBActions
    
    @IBAction func isFavorite(_ sender: UIButton) {
        isFavorite.toggle()
        switch isFavorite {
        case true:
            btnFavorite.imageView?.image = UIImage(systemName: ".heart.fill")
        case false:
            btnFavorite.imageView?.image = UIImage(systemName: ".heart")
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
