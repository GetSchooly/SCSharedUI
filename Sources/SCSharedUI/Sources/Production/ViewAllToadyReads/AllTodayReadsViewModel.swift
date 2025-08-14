//
//  AllTodayReadsViewModel.swift
//  SCSharedUI
//
//  Created by puneet dreamsoft on 31/07/25.
//

import Foundation
import Combine

class AllTodayReadsViewModel: LoadableViewModel<[TodayReadModel]> {
    
    private lazy var todayReadService: TodayReadViewService = TodayReadViewService()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var todayReads: [TodayReadModel] = []
    
   override init() {
       super.init()
        self.todayReads = mockTodayReads
       observeTodayReads()
    }
    
    private func observeTodayReads() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.todayReads = model
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchTodayReadList(limit: Int, offset: Int) {
        let publicer = todayReadService.fetchTodayReadList(limit: limit, offset: offset)
        load(publisher: publicer)
    }
}

extension AllTodayReadsViewModel{
    var mockTodayReads: [TodayReadModel]{
        return TodayReadModel.mockToadyReads
    }
}

