/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets()) // 모든 여백 제거
                /*
                 modelData.categories.keys는 이 데이터 모델에서 모든 카테고리 키를 추출한 배열
                 */
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
               Button {
                   showingProfile.toggle()
               } label: {
                   Label("User Profile", systemImage: "person.crop.circle")
               }
           }
            /*뷰를 모달 방식으로 표시하면 대상 뷰가 소스 뷰를 덮고 현재 탐색 스택을 대체한다. 앱의 일반적인 흐름에서 벗어나고 싶을 때 모달 방식으로 뷰를 제공한다.*/
           .sheet(isPresented: $showingProfile) {
               ProfileHost()
                   .environmentObject(modelData)
           }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
