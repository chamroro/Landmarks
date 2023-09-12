/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    // 프리뷰에서 environmentObject 주입해야 함.
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    // filteredLandmarks는 modelData.landmarks에서 필터링된 결과를 반환.
    // (!showFavoritesOnly || landmark.isFavorite)는 각 랜드마크에 대해 조건을 검사하는 클로저
            // !showFavoritesOnly: showFavoritesOnly가 false인 경우에는 이 부분이 true가 되므로, 이 조건은 항상 true가 됨.
            // landmark.isFavorite: 만약 랜드마크가 사용자가 선호하는 항목이라면, 이 부분은 true.
    // 전체 조건을 보면, 사용자가 선호하는 랜드마크만 표시하는 옵션(showFavoritesOnly가 true)이 활성화되었거나 랜드마크가 사용자가 선호하는 항목인 경우에만 해당 랜드마크를 반환함
    var filteredLandmarks: [Landmark] {
        //modelData.landmarks 이용
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }

    var body: some View {
        NavigationView {
            List {
                // 리스트에 최상단에 토글버튼 위치, 필터링 하는 역할
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                //두 가지 방법 중 하나로 데이터를 식별 가능하게 만들 수 있음.
                // 1. 데이터와 함께 각 요소를 고유하게 식별하는 속성에 대한 키 경로를 전달
                // ex) List(landmarks, id: \.id) { landmark in
                //       LandmarkRow(landmark: landmark) }
                // 2. 데이터 유형이 Identifiable 프로토콜을 준수
                // 이 코드에서는 키 말고 두번째 방법 사용. ModalData는 Identifiable를 준수함.
            
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
        
        ForEach(["iPhone SE (2nd generation)", "iPad Pro (11-inch) (4th generation)"], id: \.self) { deviceName in
                  LandmarkList()
                      //각각의 프리뷰에 위에 입력한 리스트의 기기를 지정
                      .previewDevice(PreviewDevice(rawValue: deviceName))
                      .environmentObject(ModelData())
                      //.previewDisplayName를 이용하여 프리뷰를 라벨링할 수 있음
                      .previewDisplayName(deviceName)
        }
        
      
        
    }
}
