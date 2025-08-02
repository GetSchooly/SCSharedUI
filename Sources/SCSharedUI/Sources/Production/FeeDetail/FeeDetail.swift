import SwiftUI
import SCTokens
import SCComponents

public struct FeeDetail: View {
    @State private var showDetails = false
    public init(showDetails: Bool = false) {
        self.showDetails = showDetails
        Font.loadMyFonts
    }
   public var body: some View {
       combinedView
    }
    
    private var combinedView: some View {
        VStack{
            topView
            if showDetails {
                bottomView
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
    }
    
    private var topView: some View {
        VStack(alignment: .leading , spacing: 0){
            VStack(spacing: 15){
                HStack{
                    SDText("December 2025", style: .size200(weight: .bold, theme: .primary, alignment: .leading))
                    Spacer()
                    SDText("01 Dec", style: .size100(weight: .medium, theme: .primary, alignment: .trailing))
                }
                
                HStack {
                    SDText("$25", style: .size100(weight: .medium, theme: .primary, alignment: .leading))
                    SDText("DUE", style: .size100(weight: .bold, theme: .standard, alignment: .leading))
                        .frame(width: 50 , height: 22)
                        .background(Color.red)
                        .cornerRadius(3)
                        
                    
                    Spacer()
                    SDImage(.local(resource: Icons.ic_Chevron_up.value, iconSize: .extraLarge, contentMode: .fit, placement: .left))
                }
                if showDetails{
                    Divider()
                        .background(.gray)
                }
            }
            .padding()
             
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.2))
         .onTapGesture {
             withAnimation {
                 showDetails.toggle()
             }
               
            }
    }
    
    private var bottomView: some View {
        
        VStack() {
            ForEach(0..<6 , id: \.self) {  index in
                switch index {
                case 0:
                    AmountDetail(title: "Tution fee", amount: 400)
                case 1:
                    AmountDetail(title: "Transportation fee", amount: 100)
                case 2:
                    AmountDetail(title: "Other fee", amount: 100)
                case 3:
                    AmountDetail(title: "Late fee", amount: 50)
                case 4:
                    AmountDetail(title: "Discount if any", amount: 25)
                default:
                    TotalAmount(title: "Total Fee", amount: 625)
                    
                }
               
            }
            SDButton("Pay Now", buttonType: .primaryButton(.size200(weight: .bold, theme: .standard, alignment: .center)), maxSize: true) {
                
            }.frame(width: 150, height: 40)
            .padding(.bottom , 10)
            
        }
                    
    }
    
    
}

#Preview {
    FeeDetail()
        
        
}

struct AmountDetail: View {
    var title:String
    var amount:Int
    var body: some View {
        HStack {
            SDText(title, style: .size300(weight: .regular, theme: .primary, alignment: .leading))
            Spacer()
            SDText("$\(amount)", style: .size300(weight: .regular, theme: .primary, alignment: .trailing))
            
        }
        .padding()
    }
}


struct TotalAmount: View {
    var title:String
    var amount:Int
    var body: some View {
        HStack {
            SDText(title, style: .size400(weight: .bold, theme: .primary, alignment: .trailing))
            
            Spacer()
            SDText("$\(amount)", style: .size400(weight: .bold, theme: .primary, alignment: .trailing))
            
        }
        .padding()
    }
}
