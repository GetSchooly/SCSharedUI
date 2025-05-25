
import SwiftUI
import SCComponents
import SCTokens

public struct SearchBarView: View {
    @State private var searchText: String = ""
    
    public init() {
        Font.loadMyFonts
        setupUI()
        initViewModel()
        
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public  var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading , 10)
            TextField("Search.." , text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
                
        }
        .frame(height: 50)
        .clipShape(.rect)
        .border(SCBorder(cornerRadius: 15, color: .lightBlue, width: 2))
        .padding(.leading , 20)
        .padding(.trailing , 20)
        
    }
}

#Preview {
    SearchBarView()
}
