import SwiftUI
import Combine

struct Toast: ViewModifier {
    // these correspond to Android values f
    // or DURATION_SHORT and DURATION_LONG
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5
    
    let message: String
    @Binding var isShowing: Bool
    let config: Config
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            if isShowing {
                Group {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                        .padding(8)
                }
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    struct Config {
        let textColor: Color
        let font: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation
        
        init(textColor: Color = Color("background"),
             font: Font = (Font.custom("DMSans-Medium", size: 14)),
             backgroundColor: Color = Color("AnimGreen").opacity(0.75),
             duration: TimeInterval = Toast.short,
             transition: AnyTransition = .opacity,
             animation: Animation = .linear(duration: 0.3)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }
}

extension View {
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: config))
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               duration: TimeInterval) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: .init(duration: duration)))
    }
}
