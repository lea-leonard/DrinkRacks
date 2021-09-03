//
//  FavoritesViewController.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 9/3/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionFavorites: UICollectionView!
    
    // :PROPERTIES
    var lstFavorites = [Favorites]()
    let sampleModel : [Drinks] =
        [Drinks(name: "Manhattan", category: "CockTail", glassType: "martini", instructions: "Some instruction for Manhattan", dateModified: nil, img: "imgMartini", favorite: true),
        Drinks(name: "Dry Martini", category: "Cocktail", glassType: "martini", instructions: "dry martini instructions", dateModified: nil, img: "manWithDrink", favorite: true),
        Drinks(name: "Vodka", category: "Vodka", glassType: "highball", instructions: "vodka on ice ", dateModified: nil, img: "ladyDrinking", favorite: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionFavorites.reloadData()
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
  
// MARK: - UICOLLECTION DATASOURCE FUNCS

extension FavoritesViewController: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionFavorites.dequeueReusableCell(withReuseIdentifier: "cellFavorites", for: indexPath) as! FavoritesCollectionCell
        
        // add custom ui design to cell
        cell.layer.cornerRadius = 25    
        
        cell.lblDrinkName.text = self.sampleModel[indexPath.row].name
        cell.lblCategory.text = self.sampleModel[indexPath.row].category
        cell.imgDrink.image = UIImage(named: self.sampleModel[indexPath.row].img!)
        //cell.imgDrink.image = UIImage(systemName: self.sampleModel[indexPath.row].img)
        
        return cell
    }
    
    
}
