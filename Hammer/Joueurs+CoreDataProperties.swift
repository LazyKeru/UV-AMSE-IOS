//
//  Joueurs+CoreDataProperties.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//
//

import Foundation
import CoreData


extension Joueurs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joueurs> {
        return NSFetchRequest<Joueurs>(entityName: "Joueurs")
    }

    @NSManaged public var nom: String?
    @NSManaged public var prenom: String?
    @NSManaged public var ensembleDesScores: NSSet?

}

// MARK: Generated accessors for ensembleDesScores
extension Joueurs {

    @objc(addEnsembleDesScoresObject:)
    @NSManaged public func addToEnsembleDesScores(_ value: Scores)

    @objc(removeEnsembleDesScoresObject:)
    @NSManaged public func removeFromEnsembleDesScores(_ value: Scores)

    @objc(addEnsembleDesScores:)
    @NSManaged public func addToEnsembleDesScores(_ values: NSSet)

    @objc(removeEnsembleDesScores:)
    @NSManaged public func removeFromEnsembleDesScores(_ values: NSSet)

}

extension Joueurs : Identifiable {

}
