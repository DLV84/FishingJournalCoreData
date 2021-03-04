//
//  CatchModalViewController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/24/21.
//

import UIKit
import MapKit
import CoreLocation

protocol ModalDelegate: AnyObject {
    func updateMyViews()
}

class CatchModalViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var fishNameTextField: UITextField!
    @IBOutlet weak var baitNameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIView!
    @IBOutlet weak var modalPhotoImageView: UIImageView!
    @IBOutlet weak var modalNavigationBarTitle: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    //MARK: - Properties
    var `catch`: Catch?
    var image: UIImage?
    var catchLocation: CLLocation?
    weak var delegate: ModalDelegate? {
        didSet {
            print("---ModalDelegate---")
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveCatchButtonTapped(_ sender: Any) {
        guard let fishName = fishNameTextField.text, !fishName.isEmpty,
              let image = modalPhotoImageView.image?.jpegData(compressionQuality: 0.5),
              let baitName = baitNameTextField.text else { return }
        
        if let `catch` = `catch` {
            CatchController.shared.updateCatch(catch: `catch`, fish: fishName, bait: baitName, image: image)
        } else {
            CatchController.shared.createCatch(fish: fishName, bait: baitName, locationName: "locationName", image: image)
        }
        
        dismiss(animated: true, completion: nil)
        self.delegate?.updateMyViews()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func updateViews() {
        guard let `catch` = `catch` else { return }
        guard let image = `catch`.image else { return }
        fishNameTextField.text = `catch`.fish
        baitNameTextField.text = `catch`.bait
        modalPhotoImageView.image = UIImage(data: image)
        modalNavigationBarTitle.title = "Edit Catch"
        saveButton.title = "Done"
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoPicker" {
            let destination = segue.destination as? PhotoPickerViewController
            destination?.delegate = self
        }
    }
}//End of class

//MARK: - Extensions
extension CatchModalViewController: PhotoSelectorDelegate {
    func photoPickerSelected(image: UIImage) {
        self.modalPhotoImageView.image = image
    }
}
