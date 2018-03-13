//
//  ViewController.swift
//  ButtonTutorial
//
//  Created by Mike Ngo on 3/12/18.
//  Copyright © 2018 Mike Ngo. All rights reserved.
//

/*  This exercise was learned from:
    https://tomylab.wordpress.com/2017/04/10/ios-app-programmatically-uilabel-uitextfield-and-uibutton/
    - Some refactoring was done here to clean up the code and make more readable functions out of it.
    - This first part goes into creating constraints using NSLayoutConstraint class methods. This is
    a painful way of creating constraints and is pretty error prone.
    - The second part goes into creating constraints using the visual format language and some
    constraints follow this pattern.
    - The third part goes into creating constraints using layout anchors, the best approach into
    creating constraints.
    Layout constraints using anchors was learned from:
    https://useyourloaf.com/blog/pain-free-constraints-with-layout-anchors/
 */

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    let label2 = UILabel()
    let textfield = UITextField()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let views = ["label": self.label, "textfield": self.textfield, "button": self.button, "label2": self.label2]
        let metrics = ["width150": 150, "high50": 50]
        backgroundProperties()
        labelProperties(labelText: "My first UILabel!", textColor: UIColor.white, labelElement: label)
        labelConstraints(views: views, labelElement: label)
        
        // Hides UILabel for learning purposes
        //self.label.isHidden = true
        
        textFieldProperties()
        textFieldConstraints(metrics: metrics, views: views)
        
        // Hides text field for learning purposes
        //self.textfield.isHidden = true
        
        uiButtonProperties()
        uiButtonConstraints(metrics: metrics, views: views)
        
        // Enter in the second label after getting text field entry
        labelProperties(labelText: "Your name is: ", textColor: UIColor.black, labelElement: label2)
        labelConstraints(views: views, labelElement: label2)
        
        // Doing constraints using the anchor properties
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textfield.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: self.textfield.bottomAnchor, constant: 20).isActive = true
        label2.topAnchor.constraint(equalTo: button.bottomAnchor,
                                       constant: 8).isActive=true
    }

    private func backgroundProperties() {
        // View the background
        let blueColor = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.view.backgroundColor = blueColor
    }
    
    private func labelProperties(labelText: String, textColor: UIColor, labelElement: UILabel) {
        // Text label attributes
        labelElement.text = labelText
        labelElement.textColor = textColor
        labelElement.textAlignment = .center
        labelElement.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        // Manually add the constraints
        labelElement.translatesAutoresizingMaskIntoConstraints = false
        
        // Adds label to the subview
        self.view.addSubview(labelElement)
    }
    
    private func labelConstraints(views: [String:UIView], labelElement: UILabel) {
        var constraints = [NSLayoutConstraint]()
        commonConstraints(views: views, uiViewType: labelElement, constraints: &constraints)
        
        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }

    private func textFieldProperties() {
        // Text field properties
        self.textfield.placeholder = "information text" // Watermark that appears
        self.textfield.isSecureTextEntry = false        // true if password field
        self.textfield.textColor = UIColor.blue
        self.textfield.textAlignment = .center
        self.textfield.backgroundColor = UIColor.white
        self.textfield.borderStyle = .line
        self.textfield.autocorrectionType = .no         // Login/password fields
        self.textfield.clearButtonMode = .whileEditing  // Removes watermark placeholder
        self.textfield.translatesAutoresizingMaskIntoConstraints = false
        
        // Adds textfield to subview
        self.view.addSubview(self.textfield)
    }
    
    private func textFieldConstraints(metrics: [String:Int], views: [String:UIView]) {
        var constraints = [NSLayoutConstraint]()
        // let views = ["textfield": self.textfield]
        commonConstraints(views: views, uiViewType: self.textfield, constraints: &constraints)
        // Textfield width
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[textfield(width150)]", options: [], metrics: metrics, views: views)
        // Textfield height
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[textfield(high50)]", options: [], metrics: metrics, views: views)
        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func uiButtonProperties() {
        // UIButton properties
        self.button.setTitle("confirm", for: .normal)           // Customize button
        self.button.setTitleColor(UIColor.blue, for: .normal)
        // If you want to modify the text colour of the button when highlight, just add self.button.setTitleColor(UIColor.red, for: .highlight)
        self.button.backgroundColor = UIColor.orange
        self.button.layer.borderColor = UIColor.black.cgColor
        self.button.layer.borderWidth = 2
        self.button.layer.cornerRadius = 3
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding highlight and color to buttons
        self.button.addTarget(self, action: #selector(self.buttonHighlight), for: .touchDown)
        self.button.addTarget(self, action: #selector(self.buttonNormal), for: .touchUpInside)
        self.button.addTarget(self, action: #selector(self.buttonNormal), for: .touchUpOutside)
        self.button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)

        // Add button to subview
        self.view.addSubview(self.button)
    }
    
    private func uiButtonConstraints(metrics: [String:Int], views: [String:UIView]) {
        var constraints = [NSLayoutConstraint]()
        commonConstraints(views: views, uiViewType: self.button, constraints: &constraints)
        
        constraints.append(NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        // Center button from vertical view
        constraints.append(NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        
        
        // Button width
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[button(width150)]", options: [], metrics: metrics, views: views)
        // Button height
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[button(high50)]", options: [], metrics: metrics, views: views)
        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func commonConstraints(views: [String:UIView], uiViewType: UIView, constraints: inout [NSLayoutConstraint]) {
        // Center button from horizontal view
        constraints.append(NSLayoutConstraint(item: uiViewType, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        // Center button from vertical view (we don't want to do this here, use layout anchors)
        // constraints.append(NSLayoutConstraint(item: uiViewType, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
    }
    
    @objc private func buttonAction(sender: UIButton) {
        guard let name = self.textfield.text else {
            self.label2.text = ""
            return
        }
        self.label2.text = "Your name is: \(name)"
    }
    
    @objc private func buttonHighlight(sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }

    @objc private func buttonNormal(sender: UIButton) {
        sender.backgroundColor = UIColor.orange
    }
}

