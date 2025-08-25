import SwiftUI
import SCComponents
import SCTokens

public struct ExamCardView: View {
    var bgColor: Color = .white
    public init(_ bgColor: Color = .white) {
        self.bgColor = bgColor
    }
    public var body: some View {
        HStack {
            subjectDateView
            Spacer()
            RoundedRectangle(cornerRadius: Sizing.sizing0xQuarter).fill(Color.lightGray).frame(width: Sizing.sizing0xHalf, alignment: .center)
            Spacer()
            timingView
        }
        .padding(Sizing.sizing4x)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
    }
    
    private var subjectDateView: some View {
        VStack(alignment: .leading) {
            VStack {
                SDText("English", style: .size300(weight: .bold, theme: .standard))
                    .lineLimit(1)
            }
            .frame(width: Constants.subjectDateViewHeight, height: Sizing.sizing10x)
            .background(Color.royalBlue)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
            
            Spacer()
            
            VStack(alignment: .leading) {
                SDText("Tomorrow, on 13 Dec 2024", style: .size100(weight: .bold, theme: .primary))
                    .lineLimit(1)
                    .padding(.top, 16)
                
                HStack {
                    HStack {
                        SDText("Marks:", style: .size75(weight: .bold, theme: .primary))
                        SDText("75", style: .size300(weight: .regular, theme: .primary))
                    }
                    RoundedRectangle(cornerRadius: Sizing.sizing0xQuarter).fill(Color.lightGray).frame(width: Sizing.sizing0xHalf, height: Sizing.sizing5x, alignment: .center)
                    HStack {
                        SDText("Passing Marks:", style: .size75(weight: .bold, theme: .primary))
                        SDText("25", style: .size300(weight: .regular, theme: .primary))
                    }
                }
            }
        }
    }
    
    private var timingView: some View {
        VStack {
            VStack(alignment: .leading) {
                SDText("Start:", style: .size100(weight: .bold, theme: .royalBlue))
                SDText("09:30 AM", style: .size100(weight: .semiBold, theme: .primary))
            }
            Spacer()
            VStack(alignment: .leading) {
                SDText("End:", style: .size100(weight: .bold, theme: .royalBlue))
                SDText("12:00 PM", style: .size100(weight: .semiBold, theme: .primary))
            }
        }
    }
}

private struct Constants {
    static let subjectDateViewHeight: CGFloat = 108
}

extension ExamCardView: HasExamples {
    static var examples: [Example] {
        [Example("ExamCardView", width: 300, height: 300) {
            ExamCardView()
        }]
    }
}

#Preview {
    ExamCardView()
        .frame(height: 182, alignment: .center)
        .padding()
}
