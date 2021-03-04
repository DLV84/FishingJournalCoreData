//
//  PhotoPickerViewController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/26/21.
//

import UIKit

//MARK: - Protocol
protocol PhotoSelectorDelegate: class {
    func photoPickerSelected(image: UIImage)
}

class PhotoPickerViewController: UIViewController, PhotoSelectorDelegate {
    func photoPickerSelected(image: UIImage) {
        print("Saved To CoreDate")
    }

    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var selectedPhotoButton: UIButton!
    
    //MARK: - Properties
    weak var delegate: PhotoSelectorDelegate?
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Actions
    @IBAction func selectPhotoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add A Photo", message: nil, preferredStyle: .alert)
    
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Methods
    func setupViews() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.backgroundColor = .black
    }
}//End of Class

//MARK: - Extensions
extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.image = pickedImage
            
            delegate?.photoPickerSelected(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
