//
//  Persistence.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 28/12/2020.
//

import Foundation
import CoreData
import os.log

class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    let log = OSLog(subsystem: "Application", category: "CoreData")

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SingaporeBreatheModel")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.stuartbreckenridge.sgbreathe")!.appendingPathComponent("database.sqlite"))]
        print(container.persistentStoreDescriptions.first!.url!.absoluteString)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { [weak self] (storeDescription, error) in
            if let error = error as NSError? {
                os_log(.error, log: self!.log, "%@", error.localizedDescription)
            } else {
                os_log(.debug, log: self!.log, "Persistent store loaded.")
                self?.deleteOldRecords()
            }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
}


// MARK: - Persistence Controller - Queries
extension PersistenceController {
    
    public func latestReadingForRegion(_ region: String) -> RegionalAQM? {
        let fr: NSFetchRequest<RegionalAQM> = NSFetchRequest(entityName: "RegionalAQM")
        let sort = NSSortDescriptor(key: "id", ascending: false)
        let predicate = NSPredicate(format: "region = %@", region)
        fr.predicate = predicate
        fr.sortDescriptors = [sort]
        return try? PersistenceController.shared.container.viewContext.fetch(fr).first
    }
    
    public func deleteAllReadings() {
        let fr: NSFetchRequest<RegionalAQM> = RegionalAQM.fetchRequest()
        let readings = try! container.viewContext.fetch(fr)
        for reading in readings {
            container.viewContext.delete(reading)
        }
        try? container.viewContext.save()
    }
    
    public func readingCount() -> Int {
        let fr: NSFetchRequest<RegionalAQM> = RegionalAQM.fetchRequest()
        let readings = try! container.viewContext.fetch(fr)
        return readings.count
    }
    
    /// Deletes records older than 30 days.
    private func deleteOldRecords() {
        os_log(.debug, log: log, "Starting deletion of old records.")
        let dateBound = Date().addingTimeInterval(-30 * 24 * 60 * 60)
        let fr: NSFetchRequest<RegionalAQM> = RegionalAQM.fetchRequest()
        let datePredicate = NSPredicate(format: "timestamp < %@", dateBound as NSDate)
        fr.predicate = datePredicate
        guard let readings = try? container.viewContext.fetch(fr) else {
            return
        }
        for reading in readings {
            container.viewContext.delete(reading)
        }
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
        os_log(.debug, log: log, "Finished deleting old records.")
    }
}
