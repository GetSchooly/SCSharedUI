import Foundation
import Combine

public struct TodayReadModel: Codable, Identifiable {
    public let id: Int
    let title: String
    let posterImage: String
    let postedAt: String
    let readingTime: String
    let description: String
    let numberOfViews: Int
    let numberOfFoundUseful: Int
    var formattedDate:String {
        let date = convertToDate(from: postedAt)
       return displayText(for: date)
    }
    
    func displayText(for date: Date) -> String {
            let calendar = Calendar.current
            let now = Date()
            
            let components = calendar.dateComponents([.day], from: date, to: now)
            if let days = components.day {
                if days < 3 {
                    if days == 0 {
                        let hours = calendar.dateComponents([.hour], from: date, to: now).hour ?? 0
                        return hours > 0 ? "\(hours) hours ago" : "Just now"
                    } else {
                        return "\(days) days ago"
                    }
                } else {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    return formatter.string(from: date)
                }
            }
            
            return ""
        }
    
    func convertToDate(from string: String) -> Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // must match your input
            //formatter.timeZone = TimeZone(secondsFromGMT: 0) // adjust if needed
            formatter.dateStyle = .medium
            formatter.timeZone = TimeZone.current
            return formatter.date(from: string) ?? Date()
        }
}

protocol TodayReadServiceProtocol {
    func fetchTodayReadList(limit: Int, offset: Int) -> AnyPublisher<ResponseModel<[TodayReadModel]>, Error>
}

class TodayReadViewService: TodayReadServiceProtocol {
    
    func fetchTodayReadList(limit: Int, offset: Int) -> AnyPublisher<ResponseModel<[TodayReadModel]>, any Error> {
        let endPoint = ParentApiEndPoint.todayReadList(limit: limit, offset: offset)
        return URLSessionAPIClient().request(endPoint)
    }
}

// MARK: - MOCK

extension TodayReadModel{
    static let mockTodayRead = TodayReadModel(
        id: 1,
        title: "Mock Today Read Title",
        posterImage: "https://picsum.photos/id/1018/200/300",
        postedAt: "2021-01-01T00:00:00Z",
        readingTime: "10 min",
        description: "Mock Today Read Description",
        numberOfViews: 100,
        numberOfFoundUseful: 100
    )
    
    static let mockToadyReads: [TodayReadModel] = Array(repeating: .mockTodayRead, count: 5)
}
