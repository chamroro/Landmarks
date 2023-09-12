/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

// LandmarkList 에서 Landmark 전달받음. NavigationLink 통해서 이동
struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark

    // $0는 클로저의 인자로 받은 요소(각각의 랜드마크)
    // $0은 클로저 안에서 첫 번째 인자를 가리키는 약속된 표현, $1, $2, $3도 있음.
    // $0.id는 각각의 랜드마크 요소의 id 프로퍼티를 참조. 이를 통해 클로저는 배열 내의 랜드마크들을 순회하면서 각 랜드마크의 id를 비교하는 역할을 하고 있음. 이를 통해 랜드마크의 세부 정보와 해당 랜드마크의 배열 내 위치를 알 수 있게 됨.
    
    // @State 를 붙이지 않는 이유는?
    // @State 속성 래퍼는 뷰 내에서 해당 값이 변할 때마다 뷰를 다시 그리도록 도와주는 기능을 함.
    // landmarkIndex는 계산된 속성(computed property)으로, 랜드마크의 인덱스를 찾아내기 위한 계산 로직만 포함하고 있음. 이 계산 로직은 뷰의 레이아웃이나 외관에 영향을 주지 않고, 단순히 데이터 처리에 사용. 따라서 사용할 필요가 없다.

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
            // 💡 패딩의 디폴트값은 몇 픽셀일까?
            // As far as I understood from Apple's documentation, there's no standard value and it's calculated based on some criteria by Apple. So, it may be different for different devices, accessibility settings of user, if user is using the app in side-by-side mode on iPad, etc... -> 명확한 값이 없다. 
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
