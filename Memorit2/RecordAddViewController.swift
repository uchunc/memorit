//
//  RecordAddViewController.swift
//  Memorit2
//
//  Created by 이우천 on 6/19/24.
//

import UIKit

protocol RecordAddViewControllerDelegate: AnyObject {
    func didAddRecord(_ record: Record)
}

class RecordAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    weak var delegate: RecordAddViewControllerDelegate?
    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addpic(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let selectedImage = selectedImage else {
            let alert = UIAlertController(title: "Error", message: "Please provide an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let description = descriptionTextField.text, !description.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please provide a description", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newRecord = Record(date: Date(), image: selectedImage, description: description)
        delegate?.didAddRecord(newRecord)
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

