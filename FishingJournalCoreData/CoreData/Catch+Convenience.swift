//
//  Catch+Convenience.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/23/21.
//

import CoreData

extension Catch {
    @discardableResult convenience init (fish: String, bait: String, locationName: String, lat: Double, long: Double, timestamp: Date = Date(), image: Data?, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.fish = fish
        self.bait = bait
        self.locationName = locationName
        self.lat = lat
        self.long = long
        self.timestamp = timestamp
        self.image = image
    }
}//End of extension
