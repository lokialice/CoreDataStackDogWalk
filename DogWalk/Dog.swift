//
//  Dog.swift
//  DogWalk
//
//  Created by Macbook Pro MD102 on 6/13/15.
//  Copyright (c) 2015 Loki. All rights reserved.
//

import UIKit
import CoreData
class Dog: NSManagedObject {
   
    @NSManaged var name:String
    @NSManaged var walks:NSOrderedSet
}
