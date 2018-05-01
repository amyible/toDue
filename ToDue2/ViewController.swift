//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 3/8/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SpriteKit
import Magnetic
import Floaty

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func showListView(_ sender: UIButton) {
    }
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
//            #if DEBUG
//                magneticView.showsFPS = true
//                magneticView.showsDrawCount = true
//                magneticView.showsQuadCount = true
//            #endif
        }
    }
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    var task: String?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationController?.navigationBar.isHidden = true;
        
        for _ in 0..<6 {
            add(nil)
        }
        let floaty = Floaty()
        floaty.addItem("New Periodic Task", icon: UIImage(named: "Image")!, handler: { item in
            self.showInputDialog2()
        })
        floaty.addItem("New Single Task", icon: UIImage(named: "Image")!, handler: { item in
           self.showInputDialog()
        })
        self.view.addSubview(floaty)
    }
    
    @objc func checkBoxAction(_ sender: UIButton)
    {
        if sender.isSelected
        {
            sender.isSelected = false
            let btnImage    = UIImage(named: "unCheckBoxImage")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }else {
            sender.isSelected = true
            let btnImage    = UIImage(named: "checkBoxImage")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }
    }
    
    func showInputDialog() {
        //Creating UIAlertController
        let alertController = UIAlertController(title: "Create New Task", message: "Enter task details\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Estimated Duration (Hours) - Example: 1.5"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Additional Notes"
        }
        
        //task deadline and importance
        let label = UILabel(frame: CGRect(x: 35, y: 95, width: 210, height: 20));
        label.text = "Select task deadline (skip if N/A)";
        label.font = UIFont(name: "GillSans-Light",
                            size: 16.0)
        alertController.view.addSubview(label);
        
        let label1 = UILabel(frame: CGRect(x: 35, y: 70, width: 200, height: 20));
        label1.text = "Flag This Task as Important";
        label1.font = UIFont(name: "GillSans-Light",
                             size: 16.0)
        alertController.view.addSubview(label1);
        
        let btnImage    = UIImage(named: "unCheckBoxImage")!
        let imageButton : UIButton = UIButton(frame: CGRect(x: 220, y: 70, width: 20, height: 20))
        imageButton.setBackgroundImage(btnImage, for: UIControlState())
        imageButton.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
        alertController.view.addSubview(imageButton)

        let datePicker = UIDatePicker(frame:CGRect(x: 10, y: 109, width: 240, height: 150))
        datePicker.minuteInterval = 15;
        datePicker.minimumDate = NSDate() as Date?;
        alertController.view.addSubview(datePicker)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let duration = alertController.textFields?[1].text
            let priority = 80;
            let deadline = datePicker.date;
            let notes = alertController.textFields?[1].text;
            let color = UIColor.colors.randomItem()
            // **** CALL TO BACKEND **** //
            //print("priority is \(priority), deadline is \(deadline), notes are \(notes ?? "")")
            let node = Node(text: name?.uppercased(), image: UIImage(named: UIImage.images.randomItem()), color: UIColor.red, radius: CGFloat(priority))
            let node2 = Node(text: "CLEAN ROOM", image: UIImage(named: UIImage.images.randomItem()), color: UIColor.green, radius: CGFloat(60))
            let node3 = Node(text: "BUY MOM GIFT", image: UIImage(named: UIImage.images.randomItem()), color: UIColor.orange, radius: CGFloat(70))
            let node4 = Node(text: "OIL CHANGE", image: UIImage(named: UIImage.images.randomItem()), color: UIColor.magenta, radius: CGFloat(50))
            self.magnetic.addChild(node)
            self.magnetic.addChild(node2)
            self.magnetic.addChild(node3)
            self.magnetic.addChild(node4)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInputDialog2() {
        //Creating UIAlertController
        let alertController = UIAlertController(title: "Create New Task", message: "Enter task details\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Estimated Duration (Hours) - Example: 1.5"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Additional Notes"
        }
        
        //task deadline and importance
        let label = UILabel(frame: CGRect(x: 35, y: 95, width: 210, height: 20));
        label.text = "Select task deadline (skip if N/A)";
        label.font = UIFont(name: "GillSans-Light",
                            size: 16.0)
        alertController.view.addSubview(label);
        
        let label1 = UILabel(frame: CGRect(x: 35, y: 70, width: 200, height: 20));
        label1.text = "Flag This Task as Important";
        label1.font = UIFont(name: "GillSans-Light",
                             size: 16.0)
        alertController.view.addSubview(label1);
        
        let btnImage    = UIImage(named: "unCheckBoxImage")!
        let imageButton : UIButton = UIButton(frame: CGRect(x: 220, y: 70, width: 20, height: 20))
        imageButton.setBackgroundImage(btnImage, for: UIControlState())
        imageButton.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
        alertController.view.addSubview(imageButton)
        
        let datePicker = UIDatePicker(frame:CGRect(x: 10, y: 109, width: 240, height: 150))
        datePicker.minuteInterval = 15;
        datePicker.minimumDate = NSDate() as Date?;
        alertController.view.addSubview(datePicker)
        
        let label2 = UILabel(frame: CGRect(x: 23, y: 250, width: 200, height: 20));
        label2.text = "Recurs:     weekly ";
        label2.font = UIFont(name: "GillSans-Light",
                             size: 16.0)
        alertController.view.addSubview(label2);
        let label3 = UILabel(frame: CGRect(x: 172, y: 250, width: 200, height: 20));
        label3.text = "monthly ";
        label3.font = UIFont(name: "GillSans-Light",
                             size: 16.0)
        alertController.view.addSubview(label3);
        
        let imageButton1 : UIButton = UIButton(frame: CGRect(x: 138, y: 250, width: 20, height: 20))
        let imageButton2 : UIButton = UIButton(frame: CGRect(x: 228, y: 250, width: 20, height: 20))
        imageButton1.setBackgroundImage(btnImage, for: UIControlState())
        imageButton2.setBackgroundImage(btnImage, for: UIControlState())
        imageButton1.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
        imageButton2.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
        alertController.view.addSubview(imageButton1)
        alertController.view.addSubview(imageButton2)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let duration = alertController.textFields?[1].text
            let priority = 40;
            let deadline = datePicker.date;
            let notes = alertController.textFields?[1].text;
            let color = UIColor.colors.randomItem()
            // **** CALL TO BACKEND **** //
            //print("priority is \(priority), deadline is \(deadline), notes are \(notes ?? "")")
            let node = Node(text: name?.uppercased(), image: UIImage(named: UIImage.images.randomItem()), color: color, radius: CGFloat(priority))
            self.magnetic.addChild(node)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIControl?) {
        let name = UIImage.names.randomItem()
        let color = UIColor.colors.randomItem()
        let image = UIImage.images.randomItem()
        let node = Node(text: name.uppercased(), image: UIImage(named: image), color: color, radius: 40)
        magnetic.addChild(node)
        
        // Image Node: image displayed by default
        // let node = ImageNode(text: name.capitalized, image: UIImage(named: name), color: color, radius: 40)
        // magnetic.addChild(node)
    }
    
    /*@IBAction func reset(_ sender: UIControl?) {
        let speed = magnetic.physicsWorld.speed
        magnetic.physicsWorld.speed = 0
        let sortedNodes = magnetic.children.compactMap { $0 as? Node }.sorted { node, nextNode in
            let distance = node.position.distance(from: magnetic.magneticField.position)
            let nextDistance = nextNode.position.distance(from: magnetic.magneticField.position)
            return distance < nextDistance && node.isSelected
        }
        var actions = [SKAction]()
        for (index, node) in sortedNodes.enumerated() {
            node.physicsBody = nil
            let action = SKAction.run { [unowned magnetic, unowned node] in
                if node.isSelected {
                    let point = CGPoint(x: magnetic.size.width / 2, y: magnetic.size.height + 40)
                    let movingXAction = SKAction.moveTo(x: point.x, duration: 0.2)
                    let movingYAction = SKAction.moveTo(y: point.y, duration: 0.4)
                    let resize = SKAction.scale(to: 0.3, duration: 0.4)
                    let throwAction = SKAction.group([movingXAction, movingYAction, resize])
                    node.run(throwAction) { [unowned node] in
                        node.removeFromParent()
                    }
                } else {
                    node.removeFromParent()
                }
            }
            actions.append(action)
            let delay = SKAction.wait(forDuration: TimeInterval(index) * 0.002)
            actions.append(delay)
        }
        magnetic.run(.sequence(actions)) { [unowned magnetic] in
            magnetic.physicsWorld.speed = speed
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination as! ModalViewController
            destinationViewController.name = task
        
        
    }
    
    
}

// MARK: - MagneticDelegate
extension ViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node, name: String) {
        task = name
        print("didSelect -> \(name)")
        performSegue(withIdentifier: "OpenModal", sender: self)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node, name: String) {
        print("didDeselect -> \(node)")
    }
    
    func madeProgress(score: Int?) {
        scoreLabel.text = (Int(scoreLabel.text!)! + score!).description
    }
}

// MARK: - ImageNode
class ImageNode: Node {
    override var image: UIImage? {
        didSet {
            sprite.texture = image.map { SKTexture(image: $0) }
        }
    }
    override func selectedAnimation() {}
    override func deselectedAnimation() {}
}

// MARK: - BorderNode
class BorderNode: Node {
    override var image: UIImage? {
        didSet {
            sprite.texture = image.map { SKTexture(image: $0) }
        }
    }
}


