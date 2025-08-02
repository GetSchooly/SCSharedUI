
import Foundation
class AllQuizListViewModel: ObservableObject {
    var allTodayReads: [QuizDataModel] = []

    init() {
        // Do something
        allTodayReads = [
            QuizDataModel(name: "Upcomming assignment", lastMessage: "Thank you very much teacher!"),
            QuizDataModel(name: "Bus is arrving in time", lastMessage: "Please be on time in your destination!"),
            QuizDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here."),
            QuizDataModel(name: "Maya Desai", lastMessage: "Thank you very much teacher!"),
            QuizDataModel(name: "Eva Bond", lastMessage: "Great work!"),
            QuizDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here."),
            QuizDataModel(name: "Maya Desai", lastMessage: "Thank you very much teacher!"),
            QuizDataModel(name: "Eva Bond", lastMessage: "Great work!"),
            QuizDataModel(name: "Vikash Singh", lastMessage: "Don't worry, Your today homework will be shared here.")
        ]
    }

    func fetchData() {
        // Do something
    }
}
