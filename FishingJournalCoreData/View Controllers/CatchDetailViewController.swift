//
//  CatchDetailViewController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/23/21.
//

import UIKit
import MapKit
import CoreLocation

class CatchDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var fishNameTextField: UITextField!
    @IBOutlet weak var baitNameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIView!
    @IBOutlet weak var detailPhotoImageView: UIImageView!
    @IBOutlet weak var locationNameTextField: UITextField!
    
    
    
    //MARK: - Properties
    var `catch`: Catch?
    var image: UIImage?
    var catchLocation: CLLocation?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    //MARK: - Actions
    @IBAction func saveCatchButtonTapped(_ sender: Any) {
        guard let fishName = fishNameTextField.text, !fishName.isEmpty,
              let image = image?.jpegData(compressionQuality: 0.5),
              let baitName = baitNameTextField.text,
              let locationName = locationNameTextField.text,
              let lat = catchLocation?.coordinate.latitude,
              let long = catchLocation?.coordinate.longitude else { return }
        
        if let `catch` = `catch` {
            CatchController.shared.updateCatch(catch: `catch`, fish: fishName, bait: baitName, image: image)
        } else {
            CatchController.shared.createCatch(fish: fishName, bait: baitName, locationName: locationName, image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Helper
    func updateViews() {
        guard let `catch` = `catch` else { return }
        guard let image = `catch`.image else { return }
        fishNameTextField.text = `catch`.fish
        baitNameTextField.text = `catch`.bait
        detailPhotoImageView.image = UIImage(data: image)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCatchModalVC" {
           guard let destination = segue.destination as? CatchModalViewController,
                 let `catch` = `catch` else { return }
            destination.`catch` = `catch`
            destination.delegate = self
        } else if segue.identifier == "toCatchMapLocationVC" {
            guard let destination = segue.destination as? MapDetailViewController,
                  let `catch` = `catch` else { return }
            let location = CLLocation(latitude: `catch`.lat, longitude: `catch`.long)
            destination.catchLocation = location
        }
    }
    
}//End of class

//MARK: - Extensions
extension CatchDetailViewController: PhotoSelectorDelegate {
    func photoPickerSelected(image: UIImage) {
//        self.photoImageView.image = image
    }
}

extension CatchDetailViewController: ModalDelegate {
    func updateMyViews() {
        self.updateViews()
    }
}
