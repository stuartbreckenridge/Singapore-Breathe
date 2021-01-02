//
//  SingaporeBreatheApp.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import SwiftUI

@main
struct SingaporeBreatheApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            PSIMapView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
