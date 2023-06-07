import SwiftUI

struct ProfileMenu: View {
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            if isExpanded {
                ForEach(Icon.allCases, id: \.self) { icon in
                    if profileMenuViewModel.icon != icon {
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                            profileMenuViewModel.icon = icon
                        }) {
                            icon.normalImage
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                    else {
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                            profileMenuViewModel.icon = icon
                        }) {
                            profileMenuViewModel.icon.selectedImage
                                .font(.system(size: 20))
                                .foregroundColor(Color("AnimGreen"))
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            else {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    profileMenuViewModel.icon.selectedImage
                        .font(.system(size: 20))
                        .foregroundColor(Color("AnimGreen"))
                }
            }
        }
        .frame(width: 40, height: isExpanded ? CGFloat(40 + (Icon.allCases.count * 30)) : 40) // Adjust the height based on the number of items in the menu
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
        .overlay(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: IconPreferenceKey.self,
                        value: IconPreferenceData(iconSize: geometry.size, iconFrame: geometry.frame(in: .global))
                    )
            }
        )
        .onPreferenceChange(IconPreferenceKey.self) { value in
            profileMenuViewModel.iconFrame = value.iconFrame
        }
    }
}




struct IconPreferenceKey: PreferenceKey {
    static var defaultValue: IconPreferenceData = .zero
    
    static func reduce(value: inout IconPreferenceData, nextValue: () -> IconPreferenceData) {
        value = nextValue()
    }
}

struct IconPreferenceData: Equatable {
    let iconSize: CGSize
    let iconFrame: CGRect
    
    static var zero: IconPreferenceData {
        IconPreferenceData(iconSize: .zero, iconFrame: .zero)
    }
}

enum Icon: String, CaseIterable {
    case user
    case animManager
    case favorites
    case settings
    
    var normalImage: AnyView {
        switch self {
        case .user:
            return AnyView(Image(systemName: "person"))
        case .animManager:
            return AnyView(
                Image("animLogoIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // Adjust the size here
            )
        case .favorites:
            return AnyView(Image(systemName: "star"))
        case .settings:
            return AnyView(Image(systemName: "gear"))
        }
    }
    
    var selectedImage: AnyView {
        switch self {
        case .user:
            return AnyView(Image(systemName: "person.fill"))
        case .animManager:
            return AnyView(
                Image("animLogoIconGreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // Adjust the size here
            )
        case .favorites:
            return AnyView(Image(systemName: "star.fill"))
        case .settings:
            return AnyView(Image(systemName: "gear"))
        }
    }
}
