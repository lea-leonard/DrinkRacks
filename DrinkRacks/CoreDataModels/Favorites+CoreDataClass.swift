//
//  Favorites+CoreDataClass.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 9/6/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Favorites)
public class Favorites: NSManagedObject {
// Insert code here to add functionality to your managed object subclass
    
    // SAVE/CREATE to Favorites
    class func newRecord(drinkDetails: Drinks) -> Bool {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let newRecord = Favorites(context: context)
                newRecord.name = drinkDetails.name
                newRecord.category = drinkDetails.category
                newRecord.glassType = drinkDetails.glassType
                newRecord.img = drinkDetails.img
                newRecord.instructions = drinkDetails.instructions
                newRecord.notes = nil
                
                //save the new record to the contet
                do{
                    try context.save()
                } catch {
                    return false
            }
            return true
        } else {
            return false
        }// end if/let
        
    }// newRecord()
    
// :MARK  do not need - used in DrinksDetailViewController
    // DELETE from Favorites
    class func deleteRecord(name drinkName: String) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let fetchReq = NSFetchRequest<Favorites>(entityName: "Favorites")
            fetchReq.predicate = NSPredicate(format: "name contains '\(drinkName)'", drinkName)
            let record = try context.fetch(fetchReq)
            try context.delete(record.first!)
            try context.save()
            return true
        } catch {
            return false
        }
        
    }
    
    // READ from Core Data Favorites
//    class func getFavorites()-> [Favorites] {
       
//    }

}// end class
