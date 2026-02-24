//
//  PhoneBook+CoreDataClass.swift
//  PokemonApp
//
//  Created by 이정인 on 2/20/26.
//
//

public import Foundation
public import CoreData

public typealias PhoneBookCoreDataClassSet = NSSet

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    
    public static let className = "PhoneBook" // static 프로퍼티는 항상 타입에 대고 호출할 수 있는 프로퍼티.
    
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let image = "image"
    }

}
