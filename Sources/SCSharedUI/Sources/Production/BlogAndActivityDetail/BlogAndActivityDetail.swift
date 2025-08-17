import SCTokens
import SCComponents
import SwiftUI

public struct BlogAndActivityDetail: View {
    @ObservedObject var viewModel: BlogAndActivityDetailModel

    public init(viewModel: BlogAndActivityDetailModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        detailsView
    }

    private var detailsView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: Spacing.spacing3x) {
                SDImage(.remote(url: viewModel.imageURL))
                    .frame(height: Constatns.imageHeight)
                    .clipped()

                SDText(viewModel.title, style: .size200(weight: .semiBold, theme: .darkGray, alignment: .leading))

                HStack(spacing: Spacing.spacing2x) {
                    let readingTime = viewModel.readingTime
                    if !readingTime.isEmpty {
                        SDButton(
                            "\(readingTime) mins read",
                            buttonType: .noStyle(.size75(weight: .regular, theme: .secondry)),
                            spacing: Spacing.spacing1xHalf,
                            icon: .local(resource: Icons.ic_Rectangle.value, iconSize: .extraSmall, contentMode: .fit)
                        ) {}
                    }

                    if !viewModel.difficulty.isEmpty {
                        HStack(spacing: Spacing.spacing1x) {
                            SDText("Difficulty :", style: .size75(weight: .semiBold, theme: .primary, alignment: .trailing))
                            SDText(viewModel.difficulty, style: .size75(weight: .regular, theme: .secondry, alignment: .trailing))
                        }
                    }

                    if !viewModel.ageGroup.isEmpty {
                        HStack(spacing: Spacing.spacing1x) {
                            SDText("Age Group :", style: .size75(weight: .semiBold, theme: .primary, alignment: .trailing))
                            SDText(viewModel.ageGroup, style: .size75(weight: .regular, theme: .secondry, alignment: .trailing))
                        }
                    }
                    Spacer()
                }

                SDText(viewModel.subtitle, style: .size90(weight: .regular, theme: .darkGray, alignment: .leading))
                if viewModel.isTodayRead{
                    extraDetail
                }

                Spacer()
            }
            .padding(.top, Spacing.spacing0x)
            .padding(.horizontal, Spacing.spacing5x)
            .padding(.bottom, Spacing.spacing2x)
        }
    }

    private var extraDetail: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing3x) {
            SDText("Material:", style: .size200(weight: .semiBold, theme: .primary, alignment: .leading))

            SDText("Paper plate, Scissors, Crayons, Glue, Elastic string.", style: .size90(weight: .regular, theme: .primary, alignment: .leading))

            SDText("Steps:", style: .size200(weight: .semiBold, theme: .primary, alignment: .leading))

            SDText("Cut eye holes in the paper plate.Decorate the plate to look like an animal face using crayons.Attach elastic string to wear as a mask.", style: .size90(weight: .regular, theme: .primary, alignment: .leading))
        }
    }
}

#Preview {
    BlogAndActivityDetail(viewModel: BlogAndActivityDetailModel(activity: DoActivitiesModel.mockActivity, todayRead: TodayReadModel.mockTodayRead, isTodayRead: false))
}

private enum Constatns {
    static let imageHeight: CGFloat = 226
}
