import Foundation

public class InboxCardViewModel: ObservableObject {
    
    @Published var inboxCardModel: InboxCardModel
    
    // MARK:- Initialize
    public init(inboxCardModel: InboxCardModel) {
        self.inboxCardModel = inboxCardModel
    }
}

