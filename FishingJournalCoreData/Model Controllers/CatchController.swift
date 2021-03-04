//
//  CatchController.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/23/21.
//

import CoreData
import MapKit
import CoreLocation

class CatchController {
    
    static let shared = CatchController()
    
    //MARK: - Properties
    var catches: [Catch] = []
    var catchLocation: CLLocation?
    
    // Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Catch> = {
        let request = NSFetchRequest<Catch> (entityName: "Catch")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    //CRUD
    //Create
    func createCatch(fish: String, bait: String, locationName: String, image: Data?) {
        guard let image = image,
              let lat = catchLocation?.coordinate.latitude,
              let long = catchLocation?.coordinate.longitude else { return }
        
        let newCatch = Catch(fish: fish, bait: bait, locationName: locationName, lat: lat, long: long, image: image)
        catches.append(newCatch)
        CoreDataStack.saveContext()
    }
    
    //Read
    func fetchCatches() {
        let catches = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.catches = catches
    }
    
    //Update
    func updateCatch(catch: Catch, fish: String, bait: String, image: Data?) {
        guard let image = image else { return }
        `catch`.fish = fish
        `catch`.bait = bait
        `catch`.image = image
    
        CoreDataStack.saveContext()
    }
    
    //Delete
    func deleteCatch(catch: Catch) {
        guard let indexToDelete = catches.firstIndex(of: `catch`) else { return }
        catches.remove(at: indexToDelete)
        CoreDataStack.container.viewContext.delete(`catch`)
        CoreDataStack.saveContext()
        
    }
}//End of class
