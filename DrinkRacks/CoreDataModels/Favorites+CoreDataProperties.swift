//
//  Favorites+CoreDataProperties.swift
//  DrinkRacks
//
//  Created by Lea W. Leonard on 9/6/21.
//  Copyright © 2021 Lea W. Leonard. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }
    

    @NSManaged public var category: String?
    @NSManaged public var glassType: String?
    @NSManaged public var img: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: NSObject?

}
