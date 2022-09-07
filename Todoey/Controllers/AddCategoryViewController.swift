//
//  AddCategoryViewController.swift
//  Todoey
//
//  Created by Samet Koyuncu on 7.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import Combine

class AddCategoryViewController: UIViewController {
    
    // Global declaration, to keep the subscription alive.
    var cancellable: AnyCancellable?
    @IBOutlet weak var selectedColorView: UIView!
    
    var selectedColor: UIColor? {
        didSet {
            self.selectedColorView.backgroundColor = self.selectedColor
        }
    }
    
    var setCategoryData: ((_ name: String, _ color: String) -> ())?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var selectColorButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add button outlets and set corner radius 20
        selectedColor = UIColor(named: "Yellow")
        
        // rounded corners
        selectedColorView.layer.cornerRadius = selectedColorView.frame.height / 2
        selectColorButton.layer.cornerRadius = selectColorButton.frame.height / 2
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    @available(iOS 14.0, *)
    @IBAction func selectColorButtonPressed(_ sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = selectedColor ?? .systemRed
        
        //  Subscribing selectedColor property changes.
        self.cancellable = picker.publisher(for: \.selectedColor)
            .sink { color in
                self.selectedColor = color
            }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // name is required
        guard let name = nameTextField.text, name != "" else {
            nameTextField.backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 0.05)
            nameTextField.placeholder = "Zorunlu alan"
            return
        }
        
        if let color = selectedColor {
            setCategoryData?(name, "\(color)")
            dismiss(animated: true)
        }
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - color picker delegate methods
/*extension AddCategoryViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
        print("selected color form m1: \(viewController.selectedColor)")
        
    }
    
    //  Called on every color selection done in the picker.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
        print("selected color form m2: \(viewController.selectedColor)")
    }
}*/
