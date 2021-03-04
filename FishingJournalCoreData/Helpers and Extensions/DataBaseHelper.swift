//
//  DataBaseHelper.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 3/1/21.
//

import UIKit

class DataBaseHelper {
    //MARK: - Shared Instance
    static let shared = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Catch(context: context)
        imageInstance.image = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}
