//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Pribelszki Levente on 2020. 12. 07..
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Counrty?

}

extension Candy : Identifiable {

}
