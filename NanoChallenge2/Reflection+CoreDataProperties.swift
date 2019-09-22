//
//  Reflection+CoreDataProperties.swift
//  NanoChallenge2
//
//  Created by Arnold Tjiawi on 23/09/19.
//  Copyright © 2019 ArnoldTjiawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}
