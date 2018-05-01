//
//  ListViewController.swift
//  ToDue2
//
//  Created by Amy Liu on 4/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

import UIKit
import os.log

class ListViewController: UITableViewController {
    //MARK: Properties
    var tasks = [Task(name: "Pick up flowers", duration: 1.5, deadline: NSDate() as Date, important: false, notes: "Hi hihi"), Task(name: "Visit Annie", duration: 2.5, deadline: NSDate() as Date, important: true, notes: "Bring cookies in pantry (peanut allergy!!)")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.rightBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        //tasks += loadTasks();
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TaskCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath);
        
        // Fetches the appropriate meal for the data source layout.
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task?.name
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ EEEE"
//        formatter.locale =  Locale(identifier: "en_US_POSIX")
//        let date = formatter.string(from: (task?.deadline)!)
        let date = relativeDateString(for: (task?.deadline)!)
        cell.detailTextLabel?.text = date
        //cell.deadlineLabel.text = task.deadline
        //cell.importantLabel.text = task.important
        //cell.taskNotesField.text = task.notes
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            //savetasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
//        switch(segue.identifier ?? "") {
//        case "AddItem":
//            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
//        case "ShowDetail":
            guard let taskDetailViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedTaskCell = sender as? UITableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }

            guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            let selectedTask = tasks[indexPath.row]
            taskDetailViewController.task = selectedTask
//
//        default:
//            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
//        }
    }
    
    
    //MARK: Private Methods
    
//    private func saveTasks() {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
//        if isSuccessfulSave {
//            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("Failed to save meals...", log: OSLog.default, type: .error)
//        }
//    }
    
    
    //MARK: Actions
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: tasks.count, section: 0)

                tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the meals.
            //saveTasks()
        }
    }
    
//    private func loadTasks() -> [Meal]? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
//    }
    
    
}

extension Calendar {
    func isDateInYesterdayTodayTomorrow(_ date: Date) -> Bool
    {
        return self.isDateInYesterday(date) || self.isDateInToday(date) || self.isDateInTomorrow(date)
    }
}

func relativeDateString(for date: Date, locale : Locale = Locale.current) -> String
{
    let dayFormatter = DateFormatter()
    dayFormatter.locale = locale
    if Calendar.current.isDateInYesterdayTodayTomorrow(date) {
        dayFormatter.dateStyle = .medium
        dayFormatter.doesRelativeDateFormatting = true
    } else {
        dayFormatter.dateFormat = "EEEE"
    }
    let relativeWeekday = dayFormatter.string(from: date)
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = locale
    dateFormatter.dateFormat = "d MMMM"
    return  relativeWeekday + ", " + dateFormatter.string(from: date)
}

