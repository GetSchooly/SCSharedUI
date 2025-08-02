//
//  ReadDataModel.swift
//  SCSharedUI
//
//  Created by puneet dreamsoft on 31/07/25.
//

import Foundation
struct ReadDataModel: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let lastMessage: String
}
