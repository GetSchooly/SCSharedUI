
import SwiftUI
import SCComponents
import SCTokens
public struct ScoreCardView: View {
    public init() {
        Font.loadMyFonts
    }
    
    public var body: some View {
        allComponent
    }
    
    var allComponent: some View {
        VStack(){
            Group{
                scoreView
                welcomeText
            }
            Spacer()
            actionbutton
        }
    }
    
    var scoreView: some View {
        ZStack {
            Circle()
                .fill(Color.royalBlue)
                .shadow(radius: 5)
            
            Circle()
                .stroke(lineWidth: 15)
                .foregroundColor(Color.white.opacity(0.9))
                .padding(10)
            
            VStack(spacing: 5) {
                SDText("Your Score", style: .size500(weight: .medium, theme: .standard, alignment: .center))
                SDText("29/30", style: .size600(weight: .bold, theme: .standard, alignment: .center))
            }
            .foregroundColor(.white)
        }
        .frame(width: 250 , height: 250)
        .padding(.top , 20)
        
    }
    
    
    private var welcomeText: some View {
        VStack(spacing: 5) {
            SDText("Congratulation", style: .size400(weight: .semiBold, theme: .royalBlue, alignment: .center))
            SDText("Great job, Nilesh Kumar! You Did It", style: .size300(weight: .medium, theme: .royalBlue, alignment: .center))
        }
        .padding(10)
       
    }
    
    
    private var actionbutton: some View {
        VStack(){
            SDButton("Share",
                     buttonType: .primaryButton(.size300(weight: .bold, theme: .standard, alignment: .center)),
                     maxSize: true) {
                
            }
                     .frame(height: 48)
                     .padding(.bottom, 5)
                     .padding(.top, 5)
            
            SDButton("Back to home",
                     buttonType: .primaryButton(.size300(weight: .bold, theme: .standard, alignment: .center)),
                     maxSize: true) {
                
            }
            .frame(height: 48)
            .padding(.top, 5)
        }
        .padding(.bottom, 10)
        
    }
    
}

#Preview {
    ScoreCardView()
        .padding()
}
