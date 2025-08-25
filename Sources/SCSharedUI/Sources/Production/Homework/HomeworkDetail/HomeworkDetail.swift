
import SwiftUI
import SCTokens
import SCComponents

struct HomeworkDetail: View {
    @Environment(\.dismiss) var dismiss
   // let onTap: (ContactOption, String) -> Void
    @State private var labelHeight: CGFloat = 0
    let homeworkDetail: StudentTask
    init(_ homeworkDetail: StudentTask) {
        Font.loadMyFonts
       // self.onTap = onTap
        self.homeworkDetail = homeworkDetail
    }
    var body: some View {
        otherDetail
            .shadow(.defaultGrayElevation)
    }
    
    
    private var topDetails: some View {
        HStack {
            SDText("Details", style: .size200(weight: .bold, theme: .primary, alignment: .leading))
            Spacer()
            Button(action: {
               dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black)
                    .padding(Spacing.spacing2x)
            }
            .background(Color.royalBlue10)
            .clipShape(.circle)
        }
    }
    
    
    public var otherDetail: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, content: {
                topDetails
                
                SDText(
                    homeworkDetail.subjectName,
                    style: .size100(
                        weight: .semiBold,
                        theme: .primary,
                        alignment: .leading
                    ),
                    icon: .local(
                        resource: Icons.ic_Syllabus.value,
                        iconSize: .large,
                        contentMode: .fit,
                        placement: .left
                    )
                )
                .padding(.bottom, Spacing.spacing1x)

                dueSubView
                workDeatilView
                Rectangle()
                    .fill(Color.appBackground)
                    .frame(height: Sizing.sizing0xQuarter)
                    .padding(.vertical, Spacing.spacing4x)
                teacherDetailsView
            })
            .padding(.top, Spacing.spacing1x)
            .padding(.horizontal, Spacing.spacing4x)
            .padding(.bottom, Spacing.spacing4x)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        
    }

    private var dueSubView: some View {
        HStack {
            HStack(content: {
                SDText(
                    "Due:",
                    style: .size90(
                        weight: .bold,
                        theme: .primary,
                        alignment: .leading
                    ),
                    icon: .local(
                        resource: Icons.ic_Attendance.value,
                        iconSize: .large,
                        contentMode: .fit,
                        placement: .left
                    )
                )
                .padding(.trailing, -Spacing.spacing0xHalf)

                SDText(
                    homeworkDetail.submissionDate,
                    style: .size90(
                        weight: .medium,
                        theme: .primary,
                        alignment: .leading
                    )
                )
            })
            .padding(.trailing, Spacing.spacing1x)
            
            HStack(content: {
                SDText(
                    "Sub:",
                    style: .size90(
                        weight: .bold,
                        theme: .primary,
                        alignment: .leading
                    ),
                    icon: .local(
                        resource: Icons.ic_Attendance.value,
                        iconSize: .large,
                        contentMode: .fit,
                        placement: .left
                    )
                )
                .padding(.trailing, -Spacing.spacing0xHalf)

                SDText(
                    homeworkDetail.submissionDate,
                    style: .size90(
                        weight: .medium,
                        theme: .primary,
                        alignment: .leading
                    )
                )
            })
        }
        .padding(.bottom, Spacing.spacing1x)
    }

    private var workDeatilView: some View {
        HStack(alignment: .top) {
            Rectangle()
                .fill(Color.royalBlue)
                .frame(width: Sizing.sizing0xHalf, height: labelHeight)

            SDText(
                homeworkDetail.remarks,
                style: .size90(
                    weight: .medium,
                    theme: .secondry,
                    alignment: .leading
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear { labelHeight = geo.size.height }
                                        .onChange(of: geo.size.height) { newValue in
                                            labelHeight = newValue
                                        }
                                }
                            )
                        
        }
    }
    
    private var teacherDetailsView: some View {
        HStack(alignment: .center, spacing: Spacing.spacing3x) {
            SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
                .background(Color.royalBlue)
                .clipShape(.circle)
            
            VStack(alignment: .leading){
                SDImage(.local(
                    resource: Icons.ic_Teachers.value,
                    iconSize: .small,
                    contentMode: .fit,
                    placement: .left
                ))
                
                SDText(
                    homeworkDetail.teacherName.uppercased(),
                    style: .size100(
                        weight: .medium,
                        theme: .primary,
                        alignment: .leading
                    )
                )
            }
            Spacer()
            
            contactButtons()
        }
    }
    
    private func contactButtons() -> some View {
        HStack(spacing: Spacing.spacing3x) {
            contactButtonUI(.ic_call) {
//                onTap(.call, "+91-1234567890")
            }
            //.disabled(teacher.contactNumber == nil)
            // .opacity(teacher.contactNumber == nil ? 0.advanced(by: 0.2) : 1)
            
            contactButtonUI(.ic_chat) {
               // onTap(.chat, "+91-1234567890")
            }
        }
    }
        private func contactButtonUI(_ icon: Icons, onTap: @escaping () -> Void) -> some View {
            HStack {
                Spacer()
                SDButton("",
                         buttonType: .noStyle(),
                         icon: .local(resource: icon.value, iconSize: .large))
                {
                   // onTap()
                }
                .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
            }
            .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
            .background(Color.lightBlue)
            .clipShape(.circle)
        }
}

#Preview {
    HomeworkDetail(StudentTask.moackDetail)
        .padding(20)
}
