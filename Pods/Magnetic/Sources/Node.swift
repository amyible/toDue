//
//  Node.swift
//  Magnetic
//
//  Created by Lasha Efremidze on 3/25/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SpriteKit

open class Node: MaskNode {
    
    public lazy var label: SKMultilineLabelNode = { [unowned self] in
        let label = SKMultilineLabelNode()
        label.fontName = "GillSans"
        label.fontSize = 13
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.width = 1 * self.frame.width / 2
        label.separator = " "
        self.mask.addChild(label)
        return label
        }()
    
    public lazy var sprite: SKSpriteNode = { [unowned self] in
        let sprite = SKSpriteNode()
        sprite.size = self.frame.size
        sprite.colorBlendFactor = 0.5
        self.mask.addChild(sprite)
        return sprite
        }()
    
    /**
     The text displayed by the node.
     */
    open var text: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    /**
     The image displayed by the node.
     */
    open var image: UIImage? {
        didSet {
            //            let url = URL(string: "https://picsum.photos/1200/600")!
            //            let image = UIImage(data: try! Data(contentsOf: url))
            texture = image.map { SKTexture(image: $0.aspectFill(self.frame.size)) }
            sprite.size = texture?.size() ?? self.frame.size
        }
    }
    
    open var size: CGFloat
    open var radius: CGFloat
    /**
     The color of the node.
     
     Also blends the color with the image.
     */
    open var color: UIColor {
        get { return sprite.color }
        set { sprite.color = newValue }
    }
    
    override open var strokeColor: UIColor {
        didSet {
            maskOverlay.strokeColor = strokeColor
        }
    }
    
    private(set) var texture: SKTexture?
    
    /**
     The selection state of the node.
     */
    open var isSelected: Bool = false {
        didSet {
            guard isSelected != oldValue else { return }
            if isSelected {
                //removeFromParent()
                selectedAnimation()
            } else {
                deselectedAnimation()
            }
        }
    }
    
    /**
     Creates a node object.
     
     - Parameters:
     - text: The text of the node.
     - image: The image of the node.
     - color: The color of the node.
     - radius: The radius of the node.
     - path: The path of the node.
     
     - Returns: A new node.
     */
    public init(text: String?, image: UIImage?, color: UIColor, radius: CGFloat, path: CGPath? = nil) {
        self.radius = radius
        self.size = radius
        super.init(path: path ?? SKShapeNode(circleOfRadius: radius).path!)
        
        self.physicsBody = {
            let body = SKPhysicsBody(circleOfRadius: radius + 10)
            body.allowsRotation = false
            body.friction = 0
            body.linearDamping = 3
            return body
        }()
        self.fillColor = .white
        self.lineWidth = 15.5
        _ = self.sprite
        _ = self.text
        if (radius > 80) {label.fontSize = 24}
        else if (radius > 60) {label.fontSize = 16}
        configure(text: text, image: image, color: color)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configure(text: String?, image: UIImage?, color: UIColor) {
        self.text = text
        self.image = image
        self.color = color
        self.strokeColor = color.withAlphaComponent(0.3)
    }
    
    // MARK: Animations
    
    override open func removeFromParent() {
        removedAnimation() {
            super.removeFromParent()
        }
    }
    
    /**
     The animation to execute when the node is selected.
     */
    open func selectedAnimation() {
        run(.scale(to: 4/3, duration: 0.2))
        if let texture = texture {
            sprite.run(.setTexture(texture))
        }
        self.strokeColor = .white
    }
    
    /**
     The animation to execute when the node is deselected.
     */
    open func deselectedAnimation() {
        run(.scale(to: 1, duration: 0.2))
        sprite.texture = nil
        self.strokeColor = self.color.withAlphaComponent(0.3)
    }
    
    /**
     The animation to execute when the node is removed.
     
     - important: You must call the completion block.
     - parameter completion: The block to execute when the animation is complete. You must call this handler and should do so as soon as possible.
     */
    
    open func removedAnimation(completion: @escaping () -> Void) {
        if (self.size > 40) {
            let c = ((self.radius - self.size)/10) + 1
            run(.scale(to: 1-(10*c/self.radius), duration: 0.2))
            self.size = self.size - 10;
            print(self.size)
        }
        else {
            let sound = SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)
            sprite.texture = nil
            self.strokeColor = self.color.withAlphaComponent(0.3)
            self.color = self.strokeColor
            self.text = ""
            run(.scale(to: 27.6/self.radius, duration: 0.06))
            run(sound)
            run(.fadeOut(withDuration: 0.16), completion: completion)
        }
    }
    
}

open class MaskNode: SKShapeNode {
    
    let mask: SKCropNode
    let maskOverlay: SKShapeNode
    
    public init(path: CGPath) {
        mask = SKCropNode()
        mask.maskNode = {
            let node = SKShapeNode(path: path)
            node.fillColor = .white
            node.strokeColor = .clear
            return node
        }()
        
        maskOverlay = SKShapeNode(path: path)
        maskOverlay.fillColor = .clear
        
        super.init()
        self.path = path
        
        self.addChild(mask)
        self.addChild(maskOverlay)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


