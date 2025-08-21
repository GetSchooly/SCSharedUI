import Foundation
import UIKit

struct ScoreFeedback {
    let title: String
    let message: String
}

class ScoreCardViewModel: ObservableObject {
    @Published private(set) var feedback: ScoreFeedback?
    @Published var scoreCardImage: UIImage?
    @Published var isShareSheetPresented: Bool = false

    init(gained: Int, total: Int) {
        let percent = scorePercentage(gained: gained, total: total)
        feedback = feedback(for: percent)
    }

    private func feedback(for score: Int) -> ScoreFeedback {
        switch score {
        case 90...100:
            return ScoreFeedback(
                title: "Outstanding! 🌟",
                message: "You’ve mastered this topic. Keep up the excellent consistency!"
            )
        case 80..<90:
            return ScoreFeedback(
                title: "Great Work 👏",
                message: "A strong performance — just a little more effort and you’ll reach the top tier."
            )
        case 70..<80:
            return ScoreFeedback(
                title: "Well Done 👍",
                message: "You’re building a solid foundation. Keep practicing to boost your confidence."
            )
        case 60..<70:
            return ScoreFeedback(
                title: "Keep Pushing 💪",
                message: "You’re making progress, but with more revision you can unlock your full potential."
            )
        case 50..<60:
            return ScoreFeedback(
                title: "Needs Focus ⚡",
                message: "You’re halfway there. Review key concepts and try again for a stronger result."
            )
        default: // below 50
            return ScoreFeedback(
                title: "Don’t Give Up 🚀",
                message: "Every expert was once a beginner. Revisit the basics, and you’ll see big improvements soon."
            )
        }
    }

    func scorePercentage(gained: Int, total: Int) -> Int {
        guard total > 0 else { return 0 }
        let percentage = (Double(gained) / Double(total)) * 100
        return Int(percentage.rounded())
    }

    func getTimeTakenInMinutes(_ value: TimeInterval) -> String {
        let secs = Int(value)
        if secs < 60 {
            return "\(Int(secs)) secs"
        }

        let mins = secs / 60
        let seconds = secs % 60
        return String(format: "%02d:%02d", mins, seconds)
    }
}
