//
//  Scores+CoreDataProperties.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//
//

import Foundation
import CoreData


extension Scores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scores> {
        return NSFetchRequest<Scores>(entityName: "Scores")
    }

    @NSManaged public var score: Double
    @NSManaged public var date: Date?
    @NSManaged public var quelJoueur: Joueurs?

}

extension Scores : Identifiable {

}
