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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true;
        
        for _ in 0..<6 {
            add(nil)
        }
        let floaty = Floaty()
        floaty.addItem("New Periodic Task", icon: UIImage(named: "Image")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "This is for recurring tasks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        floaty.addItem("New Single Task", icon: UIImage(named: "Image")!, handler: { item in
           self.showInputDialog()
        })
        self.view.addSubview(floaty)
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Create New Task", message: "Slide to assign task priority\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)

        //get the Slider values from UserDefaults
        // let defaultSliderValue = UserDefaults.standard.float(forKey: "sliderValue")
        
        //create a Slider and fit within the extra message spaces
        //add the Slider to a Subview of the sliderAlert
        let slider = UISlider(frame:CGRect(x: 20, y: 50, width: 230, height: 80))
        slider.minimumValue = 20
        slider.maximumValue = 120
        // slider.value = defaultSliderValue
        slider.isContinuous = true
        slider.tintColor = UIColor.blue
//        slider.minimumValueImage = UIImage(named: "Snow")
//        slider.maximumValueImage = UIImage(named: "Fire")!
        alertController.view.addSubview(slider)
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task Name"
        }
        
        let datePicker = UIDatePicker(frame:CGRect(x: 10, y: 110, width: 240, height: 160))
        datePicker.minuteInterval = 15
        alertController.view.addSubview(datePicker)
        
        //OK button action
        //        let sliderAction = UIAlertAction(title: "OK", style: .default, handler: { (result : UIAlertAction) -> Void in
        //            UserDefaults.standard.set(slider.value, forKey: "sliderValue")
        //        })
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            //let priority = alertController.textFields?[1].text
            let priority = slider.value
            let deadline = datePicker.date
            let notes = alertController.textFields?[1].text
            let color = UIColor.colors.randomItem()
            print("priority is \(priority), deadline is \(deadline), notes are \(notes ?? "")")
            let node = Node(text: name?.uppercased(), image: UIImage(named: UIImage.images.randomItem()), color: color, radius: CGFloat(priority))
            self.magnetic.addChild(node)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Additional Notes"
        }
        
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
    
}

// MARK: - MagneticDelegate
extension ViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
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


