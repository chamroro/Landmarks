/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The top-level definition of the Landmarks app.
*/

import SwiftUI

@main
struct LandmarksApp: App {
    // @StateObject를 통해 앱의 수명 동안 단 한 번만 ModelData 객체를 초기화하고, ContentView로 전달.
    // 이를 통해 모든 뷰에서 ModelData의 변경을 관찰하고 업데이트할 수 있게 됨.
    // 이 패턴은 모델 데이터를 여러 뷰 사이에서 공유하고 상태 변화를 추적하는데 유용하며, SwiftUI의 데이터 흐름 관리에 사용됨. 
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
            // 하위 뷰에서 모두 모델 데이터를 사용할 수 있도록 값 주입.
                .environmentObject(modelData)
        }
    }
}
