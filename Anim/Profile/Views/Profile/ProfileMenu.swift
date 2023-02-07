import SwiftUI
import Combine

struct ProfileMenu: View {

    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    @State private var icon = "settings"
    @State private var anim = "AppIcon" //dynamic
    
    @State var secondsElapsed = 0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    @State var opacity = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.resetCounter()
                withAnimation {
                    opacity += 0.8
                    secondsElapsed = 0
                }
                profileMenuViewModel.icon = .user
            }) {
                if profileMenuViewModel.icon.rawValue == "user" {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                }
                else {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            
            Button(action: {
                self.resetCounter()
                withAnimation {
                    opacity += 0.8
                }
                profileMenuViewModel.icon = .animManager
            }) {
                if profileMenuViewModel.icon.rawValue == "Anim Manager" {
                    Image("animLogoIconBlue")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .font(.system(size: 20))
                }
                else {
                    Image("animLogoIcon")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .font(.system(size: 20))
                }
            }
            Spacer()
            
            Button(action: {
                self.resetCounter()
                withAnimation {
                    opacity += 0.8
                }
                profileMenuViewModel.icon = .favorites
            }) {
                if profileMenuViewModel.icon.rawValue == "favorites" {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                }
                else {
                    Image(systemName: "star")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            
            Button(action: {
                self.resetCounter()
                withAnimation {
                    opacity += 0.8
                }
                profileMenuViewModel.icon = .settings
            }) {
                if profileMenuViewModel.icon.rawValue == "settings" {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                }
                else {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
        }
        .frame(width: 40,height: 200)
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
        .opacity(opacity)
        .onAppear(){
            self.instantiateTimer()
        }
        
        .onReceive(timer) { _ in
            self.secondsElapsed += 1
            if secondsElapsed >= 5 && opacity > 0.5 {
                withAnimation {
                    opacity -= 0.8
                }
                self.resetCounter()
            }
        }
    }
    
    func getIcon() -> String{
        return icon
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
    
    func cancelTimer() {
        self.connectedTimer?.cancel()
        return
    }
    
    func resetCounter() {
        self.secondsElapsed = 0
        return
    }
    
    func restartTimer() {
        self.secondsElapsed = 0
        self.cancelTimer()
        self.instantiateTimer()
        return
    }
}



struct ProfileMenu_Previews: PreviewProvider {
    static var previews: some View {
        PillTabBar()
    }
}
