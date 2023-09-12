/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that clips an image to a circle and adds a stroke and shadow.
*/

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        // .overlay는 SwiftUI에서 사용되는 뷰 조합 기술 중 하나로, 한 뷰 위에 다른 뷰를 겹쳐서 표시할 때 사용됩니다. 즉, 기본적인 뷰 위에 추가적인 뷰를 덧씌워서 렌더링할 수 있도록 도와주는 역할
        // 그럼 ZStack과는 어떻게 다르게 활용할 수 있을까?
        // .overlay: 기존 뷰 위에 작은 부분적인 정보나 시각적 요소를 추가하는데 주로 사용됨. 따라서 기존 뷰의 레이아웃을 따르며, 주로 부가 정보를 제공하거나 간단한 효과를 적용하는 데에 적합.
        
        // ZStack은 여러 뷰를 쌓아 올려서 표시하는데 사용됨. 뷰의 크기와 위치를 개별적으로 지정하여 복잡한 레이아웃을 만들거나, 여러 개의 뷰를 겹쳐서 특정 시각적 효과를 구현할 때 유용.

        // 어떤 것을 선택해야 할지는 사용하는 시나리오에 따라 다름. 작은 부가 정보를 추가하려면 .overlay를 사용하고, 여러 개의 뷰를 쌓아서 구성하려면 ZStack을 사용하는 것이 좋음.
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
