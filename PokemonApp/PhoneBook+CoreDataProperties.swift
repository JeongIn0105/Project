//
//  PhoneBook+CoreDataProperties.swift
//  PokemonApp
//
//  Created by 이정인 on 2/20/26.
//
//

public import Foundation
public import CoreData


public typealias PhoneBookCoreDataPropertiesSet = NSSet

extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension PhoneBook : Identifiable {

}
