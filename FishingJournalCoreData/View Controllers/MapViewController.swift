//
//  MapViewController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 3/2/21.
//

import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationButton: UIButton!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: - Properties
    var testLocation : CLLocation?

//    var testLocation = CLLocation(latitude: 40.759011, longitude: -73.984472)
    
    //MARK: - Actions
    @IBAction func locationButtonTapped(_ sender: Any) {
        guard let currentLocation = locationManager.location else { return }

        currentLocation.lookUpLocationName { (name) in
            self.updateLocationOnMap(to: currentLocation, with: name)
            CatchController.shared.catchLocation = currentLocation
        }
//        self.updateLocationOnMap(to: testLocation, with: "max")
    }
    
    @IBAction func saveCatchLocationButtonTapped(_ sender: Any) {
        guard let currentLocation = locationManager.location else { return }
        CatchController.shared.catchLocation = currentLocation
    }
    
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    //MARK: - Functions
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.setRegion(viewRegion, animated: true)
    }
}//End of class

    //MARK: - Extensions

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first
        else { return }
        
        location.lookUpLocationName { (name) in
            self.updateLocationOnMap(to: location, with: name)
        }
    }
}//End of extension

//Adds the Full Address of the location as title to the annotation
extension CLLocation {
    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
        
        lookUpPlaceMark { (placemark) in
            handler(placemark?.name)
        }
    }
}//End of extension
