//
//  Trippy_Swift_UIApp.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/19/20.
//

import SwiftUI

@main
struct Trippy_Swift_UIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(TrippyViewModel())
        }
    }
}
