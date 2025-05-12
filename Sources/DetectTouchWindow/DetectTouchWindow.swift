// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import DetectTouchObservableObject
import WebSocketModule
public class DetectTouchAppDelegate: NSObject, UIApplicationDelegate{
    public func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = DetectTouchSceneDelegate.self
        return sceneConfig
    }
}
public class DetectTouchSceneDelegate: NSObject, UIWindowSceneDelegate{
    public var window: UIWindow?

    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = DetectTouchWindow(windowScene: scene)
        self.window = window
        self.window?.rootViewController = scene.keyWindow?.rootViewController
        self.window?.makeKeyAndVisible()
    }
}
private class DetectTouchWindow: UIWindow{
    override func sendEvent(_ event: UIEvent) {
        /*
         객체 UIApplication는 이 메서드를 호출하여 이벤트를 창에 전달합니다. 창 객체는 터치 이벤트를 터치가 발생한 뷰에 전달하고, 다른 유형의 이벤트를 가장 적합한 대상 객체에 전달합니다. 필요에 따라 앱에서 이 메서드를 호출하여 사용자가 만든 사용자 지정 이벤트를 전달할 수 있습니다. 예를 들어, 이 메서드를 호출하여 사용자 지정 이벤트를 창의 응답자 체인에 전달할 수 있습니다.
         */
        super.sendEvent(event)
        guard let touch = event.allTouches else {
            return
        }
        Task{
            if touch.filter({$0.phase == .ended}).count > 0 {
                await DetectTouchObservableObject.shared.setTouching(false)
            }else{
                await DetectTouchObservableObject.shared.setTouching(true)
            }
        }
    }
}
