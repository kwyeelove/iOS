//
//  TodoItem.swift
//  CoreDataTodo
//
//  Created by Kiwon on 22/08/2019.
//  Copyright © 2019 kwyee. All rights reserved.
//

import Foundation
import CoreData


public class TodoItem: NSManagedObject, Identifiable {
    @NSManaged public var createAt: Date?
    @NSManaged public var title: String?
    
}

extension TodoItem {
    static func getAllTodoItems() -> NSFetchRequest<TodoItem> {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest() as! NSFetchRequest<TodoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
