import Foundation

final class ProfileMenuViewModel: ObservableObject {
    @Published var icon: Icon = .settings
    @Published var iconFrame: CGRect = .zero
}
