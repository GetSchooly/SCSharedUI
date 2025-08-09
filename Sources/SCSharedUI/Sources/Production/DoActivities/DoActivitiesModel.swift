import Foundation
import Combine

enum Difficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

public struct DoActivitiesModel: Codable, Identifiable {
    public let id: Int
    let title: String
    let image: String
    let difficulty: Difficulty
    let description, category, ageGroup: String?
    let materials, steps: [String]
}

protocol DoActivitiesServiceProtocol {
    func fetchChildrenActivities(limit:Int, offset:Int) -> AnyPublisher<ResponseModel<[DoActivitiesModel]>, Error>
}

class DoActivitiesViewService: DoActivitiesServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchChildrenActivities(limit:Int, offset:Int) -> AnyPublisher<ResponseModel<[DoActivitiesModel]>, any Error> {
        let endPoint = ParentApiEndPoint.childrenActivities(limit: limit, offset: offset)
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
public extension DoActivitiesModel {
    static let mockActivity = DoActivitiesModel(
        id: 1,
        title: "Clay Elephant",
        image: "https://example.com/images/elephant.jpg",
        difficulty: .medium,
        description: "Making a clay elephant is an engaging and educational DIY activity that introduces kids to the world of sculpting. Using modeling clay, ",
        category: "Art",
        ageGroup:"8-10",
        materials: ["Clay",
                    "Sculpting tools"],
        steps: [
            "Shape the body.",
            "Add ears and trunk.",
            "Smooth the surface."
        ]
    )

    static let mockActivities: [DoActivitiesModel] = [
        DoActivitiesModel(
            id: 1,
            title: "Clay Elephant",
            image: "https://example.com/images/elephant.jpg",
            difficulty: .medium,
            description: "Making a clay elephant is an engaging and educational DIY activity that introduces kids to the world of sculpting. Using modeling clay, ",
            category: "Art",
            ageGroup:"8-10",
            materials: ["Clay",
                        "Sculpting tools"],
            steps: [
                "Shape the body.",
                "Add ears and trunk.",
                "Smooth the surface."
            ]
        ),
        DoActivitiesModel(
            id: 2,
            title: "Clay Elephant",
            image: "https://example.com/images/elephant.jpg",
            difficulty: .medium,
            description: "Making a clay elephant is an engaging and educational DIY activity that introduces kids to the world of sculpting. ",
            category: "Art",
            ageGroup:"8-10",
            materials: ["Clay",
                        "Sculpting tools"],
            steps: [
                "Shape the body.",
                "Add ears and trunk.",
                "Smooth the surface."
            ]
        ),
        DoActivitiesModel(
            id: 3,
            title: "Clay Elephant",
            image: "https://example.com/images/elephant.jpg",
            difficulty: .medium,
            description: "Making a clay elephant is an engaging and educational DIY activity that introduces kids to the world of sculpting. Using modeling clay, children can learn to shape, mold, and combine different pieces to create the adorable figure of an elephant. This hands-on activity is perfect for encouraging creativity, improving hand-eye coordination, and developing fine motor skills. Kids can start by rolling clay into balls and cylinders to form the elephant’s body parts such as the body, head, trunk, ears, and legs. By gently pressing and smoothing these parts together, they create a realistic elephant shape. After assembling, children can add details like tiny eyes, textured skin, and even paint or decorate their creations. This craft is ideal for classroom art projects, rainy afternoons at home, or as part of a wildlife-themed learning session. It helps kids explore their imagination while also learning about animals and nature. The process of sculpting clay is calming and rewarding, allowing kids to see their ideas take shape right in front of them, ultimately building their confidence and artistic skills.",
            category: "Art",
            ageGroup:"8-10",
            materials: ["Clay",
                        "Sculpting tools"],
            steps: [
                "Shape the body.",
                "Add ears and trunk.",
                "Smooth the surface."
            ]
        ),
        DoActivitiesModel(
            id: 4,
            title: "Clay Elephant",
            image: "https://example.com/images/elephant.jpg",
            difficulty: .medium,
            description: "Making a clay elephant is an engaging and educational DIY activity that introduces kids to the world of sculpting. Using modeling clay, children can learn to shape, mold, and combine different pieces to create the adorable figure of an elephant. This hands-on activity is perfect for encouraging creativity, improving hand-eye coordination, and developing fine motor skills. Kids can start by rolling clay into balls and cylinders to form the elephant’s body parts such as the body, head, trunk, ears, and legs. By gently pressing and smoothing these parts together, they create a realistic elephant shape. After assembling, children can add details like tiny eyes, textured skin, and even paint or decorate their creations. This craft is ideal for classroom art projects, rainy afternoons at home, or as part of a wildlife-themed learning session. It helps kids explore their imagination while also learning about animals and nature. The process of sculpting clay is calming and rewarding, allowing kids to see their ideas take shape right in front of them, ultimately building their confidence and artistic skills.",
            category: "Art",
            ageGroup:"8-10",
            materials: ["Clay",
                        "Sculpting tools"],
            steps: [
                "Shape the body.",
                "Add ears and trunk.",
                "Smooth the surface."
            ]
        )
    ]
}
