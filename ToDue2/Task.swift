//
//  Task.swift
//  ToDue2
//
//  Created by Amy Liu on 3/21/18.
//

import UIKit
import os.log

class Task: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var duration: Double
    var deadline: Date
    var important: Bool
    var notes: String
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let duration = "duration"
        static let deadline = "deadline"
        static let important = "important"
        static let notes = "notes"
    }
    
    //MARK: Initialization
    init?(name: String, duration: Double, deadline: Date?, important: Bool, notes: String?) {
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The duration must be > 0
        guard (duration > 0) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.duration = duration
        self.deadline = deadline!
        self.important = important
        self.notes = notes!
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(duration, forKey: PropertyKey.duration)
        aCoder.encode(deadline, forKey: PropertyKey.deadline)
        aCoder.encode(important, forKey: PropertyKey.important)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Task object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let duration = aDecoder.decodeDouble(forKey: PropertyKey.duration)
        
        let deadline = aDecoder.decodeObject(forKey: PropertyKey.deadline) as! Date?
        
        let important = aDecoder.decodeBool(forKey: PropertyKey.important)
        
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
        
        // Must call designated initializer.
        self.init(name: name, duration: duration, deadline: deadline, important: important, notes: notes);
    }
}

