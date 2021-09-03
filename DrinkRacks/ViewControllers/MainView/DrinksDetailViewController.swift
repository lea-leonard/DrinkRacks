//
//  DrinksDetailViewController.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 8/26/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//

import UIKit

class DrinksDetailViewController: UIViewController {

    // OUTLETS for Static View
    @IBOutlet weak var viewDrinkName: UIView!
    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var viewGlassType: UIView!
    @IBOutlet weak var viewInstruction: UIView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    
    // OUTLETS for Dynamic Data from Segue
    @IBOutlet weak var lblGlassType: UILabel!
    @IBOutlet weak var imgDrink: UIImageView!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var lblDrinkName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
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
        
        // TEST TO SEE  Drink Detail Model
        if let drink = drinkDetail {
            print("Detail are \(drink.name)")
        } else {
            print("NO DATA WAS PASSED")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let aDrink = drinkDetail {
            self.lblGlassType.text = aDrink.glassType
            guard let urlImg = URL(string: aDrink.img ?? "none") else {
                return
            }
            if let imgData = try? Data(contentsOf: urlImg){
                self.imgDrink.image = UIImage(data: imgData)
            }
            self.lblInstructions.text = aDrink.instructions
            self.lblDrinkName.text = aDrink.name
            self.lblCategory.text = aDrink.category
            let formatDate = DateFormatter()
            formatDate.dateFormat = "MMM YYYY"
            let strDate = String(describing: aDrink.dateModified)
            let convertDate = formatDate.date(from: strDate)
           // guard formatDate.date(from: strDate) != nil else {
             //   assert(false, "no latest date")
            //}
            self.lblDate.text = strDate
        }
            
    }// end viewWillAppear
    
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
