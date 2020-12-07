//
//  Counrty+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Pribelszki Levente on 2020. 12. 07..
//
//

import Foundation
import CoreData


extension Counrty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counrty> {
        return NSFetchRequest<Counrty>(entityName: "Counrty")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?

    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }

    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Counrty {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Counrty : Identifiable {

}
