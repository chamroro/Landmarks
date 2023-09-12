/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

// transition https://seons-dev.tistory.com/208
// animation 1 https://seons-dev.tistory.com/39
// animation 2 https://seons-dev.tistory.com/entry/SwiftUI-Animation-2
// animation 3 https://seons-dev.tistory.com/207

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
//      AnyTransition.slide
        // asymmetric 시작하는 시점(insertion)과 사라지는 지점(removal)을 정할 수 있음.
        // 투명도 변화와 함께 오른쪽에서 등장해서 작아짐
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
   
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = true
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()
                // 버튼 클릭 시 버튼이 90도 돌아가며 1.5배 커짐
                Button {
                    /*
                     애니메이션이 어떻게 중단되는지 확인하려면 애니메이션 속도를 늦추면 된다.
                     tip: 미세한 세부 사항을 관찰하고 조정할 수 있을 만큼 충분히 늦춘다.
                     상태 변경과 같은 중단 중에 애니메이션이 어떻게 작동하는지 테스트하는 빠른 방법! 
                     */
//                    withAnimation(.easeInOut(duration: 4)){
//                        showDetail.toggle()
//                    }
                    withAnimation() {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade) //transition 추출
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikes[0])
                .padding()
            Spacer()
        }
    }
}
