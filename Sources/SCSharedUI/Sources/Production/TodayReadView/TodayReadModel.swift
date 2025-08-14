import Foundation
import Combine

public struct TodayReadModel: Codable, Identifiable, Hashable {
    public let id: Int
    let title: String
    let posterImage: String
    let postedAt: String
    let readingTime: String
    let description: String
    let numberOfViews: Int
    let numberOfFoundUseful: Int
}

protocol TodayReadServiceProtocol {
    func fetchTodayReadList(limit:Int, offset:Int) -> AnyPublisher<ResponseModel<[TodayReadModel]>, Error>
}

class TodayReadViewService: TodayReadServiceProtocol {
    
    func fetchTodayReadList(limit:Int, offset:Int) -> AnyPublisher<ResponseModel<[TodayReadModel]>, any Error> {
        let endPoint = ParentApiEndPoint.todayReadList(limit: limit, offset: offset)
        return URLSessionAPIClient().request(endPoint)
    }
}

// MARK: - MOCK

public extension TodayReadModel{
    static let mockTodayRead = TodayReadModel(
        id: 1,
        title: "Mock Today Read Title",
        posterImage: "https://picsum.photos/id/1018/200/300",
        postedAt: "202020",
        readingTime: "10 min",
        description: "Mock Today Read Description",
        numberOfViews: 100,
        numberOfFoundUseful: 100
    )
    
    static let mockToadyReads: [TodayReadModel] = Array(repeating: .mockTodayRead, count: 5)
}
