import SwiftUI
import SCTokens
import SCComponents

public struct HomeworkCard: View {
    private let studentTask: StudentTask

    public init(studentTask: StudentTask) {
        self.studentTask = studentTask
    }

    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, content: {
                SDText(
                    studentTask.subjectName.capitalized,
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

                SDText(
                    studentTask.teacherName.capitalized,
                    style: .size100(
                        weight: .semiBold,
                        theme: .primary,
                        alignment: .leading
                    ),
                    icon: .local(
                        resource: Icons.ic_Teachers.value,
                        iconSize: .large,
                        contentMode: .fit,
                        placement: .left
                    )
                )
                .padding(.bottom, Spacing.spacing1x)

                dueSubView

                workDeatilView
            })
            .padding(.top, Spacing.spacing1x)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
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
                    studentTask.submissionDate,
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
                    studentTask.submissionDate,
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
        HStack {
            Rectangle()
                .fill(Color.royalBlue)
                .frame(width: Sizing.sizing0xQuarter, height: Sizing.sizing8x)

            SDText(
                studentTask.remarks,
                style: .size90(
                    weight: .medium,
                    theme: .darkGray,
                    alignment: .leading
                )
            )
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension HomeworkCard: HasExamples {
    static var examples: [Example] {
        [Example("HomeworkCard", width: 300, height: 300) {
            HomeworkCard(studentTask: StudentTask.mockTasks.studentTask[0])
        }]
    }
}

#Preview {
    VStack(content: {
        HomeworkCard(studentTask: StudentTask.mockTasks.studentTask[0])
    })
    .padding()
}
