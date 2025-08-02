//
//  AllTodayReadsViewModel.swift
//  SCSharedUI
//
//  Created by puneet dreamsoft on 31/07/25.
//

import Foundation
class AllTodayReadsViewModel: ObservableObject {

    var allTodayReads: [ReadDataModel] = []

    init() {
        // Do something
        allTodayReads = [
            ReadDataModel(name: "Upcomming assignment", lastMessage: "Thank you very much teacher!"),
            ReadDataModel(name: "Bus is arrving in time", lastMessage: "Please be on time in your destination!"),
            ReadDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here."),
            ReadDataModel(name: "Maya Desai", lastMessage: "Thank you very much teacher!"),
            ReadDataModel(name: "Eva Bond", lastMessage: "Great work!"),
            ReadDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here."),
            ReadDataModel(name: "Maya Desai", lastMessage: "Thank you very much teacher!"),
            ReadDataModel(name: "Eva Bond", lastMessage: "Great work!"),
            ReadDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here.")
        ]
    }

    func fetchData() {
        // Do something
    }
}
